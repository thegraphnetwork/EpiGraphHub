""" 
@author Luã Bida Vacaro | github.com/luabida
@date Last change on 2023-03-14

This is an Airflow DAG. This DAG is responsible for running scripts for
collecting data from PySUS SINAN. The API that fetches the data is 
available on:
https://github.com/AlertaDengue/PySUS
A detailed article about the Airflow used in EpiGraphHub can be found
at our website https://www.epigraphhub.org/ or EGH's GitHub Pages:
https://github.com/thegraphnetwork/thegraphnetwork.github.io.

Task Summary
------------

start (PythonOperator): 
    This task is the start of the task flow. It will count the rows for
    a disease and store it as a XCom value.

extract (PythonOperator):
    This task downloads parquet file from DataSUS via PySUS for a SINAN
    disease.

upload (PythonOperator):
    This task will upload a list of parquet files extracted into the EGH
    Postgres Database, parsing the disease name according to the docs:
    https://epigraphhub.readthedocs.io/en/latest/instruction_name_tables.html#all-names-schema-name-table-name-and-column-names

diagnosis (PythonOperator):
    This task will compare the number of rows before and after the insertion
    and store the values as XComs.

remove_parquets (PythonOperator):
    This task will remove the parquet files returned from the extract task

done (PythonOperator):
    This task will fail if any task above fails, breaking the DAG.

"""
import shutil
import pendulum
import pandas as pd
import logging as logger

from ftplib import FTP
from operator import is_not
from itertools import chain
from functools import partial
from datetime import timedelta
from pysus.online_data import SINAN

from airflow import DAG
from airflow.decorators import task, dag
from airflow.models import DagRun, TaskInstance

from epigraphhub.settings import env
from epigraphhub.connection import get_engine
from epigraphhub.data.brasil.sinan import (
    FTP_SINAN,
    extract,
    viz,
    DISEASES,
    normalize_str,
)

DEFAULT_ARGS = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=2),
}


def task_flow_for(disease: str):
    """
    This function is a task flow creator, it will be responsible for
    creating the task dependencies for the SINAN disease that is passed
    in. SINAN DAGs will have the same workflow.
    """

    schema = 'brasil'
    tablename = "sinan_" + normalize_str(disease) + "_m"
    engine = get_engine(credential_name=env.db.default_credential)

    prelim_years = list(map(int, FTP_SINAN(disease).get_years('prelim')))
    finals_years = list(map(int, FTP_SINAN(disease).get_years('finais')))

    @task(task_id="start")
    def start_task():
        """
        Task to start the workflow, extracts all the last update date
        for the each DBC file in FTP server. SINAN DAG will use the
        previous start task run to decide rather the dbc should be
        inserted into DB or not.
        """
        with engine.connect() as conn:
            conn.execute(
                f'CREATE TABLE IF NOT EXISTS {schema}.sinan_update_ctl ('
                ' disease TEXT NOT NULL,'
                ' year INT NOT NULL,'
                ' prelim BOOL NOT NULL,'
                ' last_insert DATE'
                ')'
            )
    
    @task(task_id="get_updates")
    def dbcs_to_fetch() -> dict:
        all_years = prelim_years + finals_years

        db_years = []
        with engine.connect() as conn:
            cur = conn.execute(
                f'SELECT year FROM {schema}.sinan_update_ctl'
                f' WHERE disease = {disease}'
            )
            db_years.extend(list(chain(*cur.all())))
        not_inserted = [y for y in all_years if y not in db_years]

        db_prelimns = []
        with engine.connect() as conn:
            cur = conn.execute(
                f'SELECT year FROM {schema}.sinan_update_ctl'
                f' WHERE disease = {disease} AND prelim IS True'
            )
            db_years.extend(list(chain(*cur.all())))
        prelim_to_final = [y for y in finals_years if y in db_prelimns]
        prelim_to_update = [y for y in prelim_years if y in db_prelimns]

        return dict(
            to_insert = not_inserted,
            to_finals = prelim_to_final,
            to_update = prelim_to_update
        )

    @task(task_id="extract")
    def extract_parquets(**kwargs) -> dict:
        ti = kwargs["ti"]
        years = ti.xcom_pull(task_ids="get_updates")

        extract_pqs = lambda stage: extract.download(
            disease=disease, years=years[stage]
            ) if any(years[stage]) else []

        return dict(
            pqs_to_insert = extract_pqs('to_insert'),
            pqs_to_finals = extract_pqs('to_finals'),
            pqs_to_update = extract_pqs('to_update')
        )
    
    @task(task_id='first_insertion')
    def upload_not_inserted(**kwargs):
        ti = kwargs["ti"]
        parquets = ti.xcom_pull(task_ids="extract")
        get_year = lambda file: int(str(file).split('.parquet')[0][-2:])

        finals, prelims = ([], [])
        for parquet in parquets:
            (
                finals.append(parquet) 
                if get_year(parquet) in finals_years 
                else prelims.append(get_year(parquet))
            )

        upload = lambda df: df.to_sql(
            name=tablename,
            con=engine.connect(),
            schema=schema,
            if_exists='append'
        )

        for final_pq in finals:
            df = viz(final_pq)
            df['year'] = (get_year(final_pq))
            df['prelim'] = (False)
            upload(df)
            logger.info(f'{final_pq} inserted into db')
            with engine.connect() as conn:
                conn.execute(
                    f'INSERT INTO {schema}.sinan_update_ctl('
                    'disease, year, prelim, last_insert) VALUES ('
                    f'{disease},{get_year(final_pq)},False,{ti.execution_date})'
                )

        for prelim_pq in prelims:
            df = viz(prelim_pq)
            df['year'] = (get_year(prelim_pq))
            df['prelim'] = (True)
            upload(df)
            logger.info(f'{prelim_pq} inserted into db')
            with engine.connect() as conn:
                conn.execute(
                    f'INSERT INTO {schema}.sinan_update_ctl('
                    'disease, year, prelim, last_insert) VALUES ('
                    f'{disease},{get_year(prelim_pq)},True,{ti.execution_date})'
                )






    @task(task_id="extract", retries=3)
    def download(disease: str) -> list:
        """
        This task is responsible for downloading every year found for
        a disease. It will download at `/tmp/pysus/` and return a list
        with downloaded parquet paths.
        """
        years = FTP_SINAN(disease).get_years()
        parquet_dirs = extract.download(disease=disease, years=years)
        logger.info(f"Data for {disease} extracted")
        return parquet_dirs

    @task(task_id="upload")
    def upload(disease: str, **kwargs) -> None:
        """
        This task is responsible for uploading each parquet dir into
        postgres database. It receives the disease name and the xcom
        from `download` task to insert.
        """
        ti = kwargs["ti"]
        parquets_dirs = ti.xcom_pull(task_ids="extract")
        for dir in parquets_dirs:
            try:
                loading.upload(disease=disease, parquet_dir=dir)
                logger.info(f"{dir} inserted into db")
            except Exception as e:
                logger.error(e)
                raise e

    @task(task_id="diagnosis")
    def compare_tables_rows(**kwargs) -> int:
        """
        This task will be responsible for checking how many rows were
        inserted into a disease table. It will compare with the start
        task and store the difference as a xcom.
        """
        ti = kwargs["ti"]
        ini_rows_amt = ti.xcom_pull(task_ids="start")
        end_rows_amt = _count_table_rows()

        new_rows = end_rows_amt["rows"] - ini_rows_amt["rows"]

        logger.info(f"{new_rows} new rows inserted into brasil.{tablename}")

        ti.xcom_push(key="rows", value=ini_rows_amt["rows"])
        ti.xcom_push(key="new_rows", value=new_rows)

    @task(trigger_rule="all_done")
    def remove_parquets(**kwargs) -> None:
        """
        This task will be responsible for deleting all parquet files
        downloaded. It will receive the same parquet dirs the `upload`
        task receives and delete all them.
        """
        ti = kwargs["ti"]
        parquet_dirs = ti.xcom_pull(task_ids="extract")

        for dir in parquet_dirs:
            shutil.rmtree(dir, ignore_errors=True)
            logger.warning(f"{dir} removed")

    @task(trigger_rule="none_failed")
    def done(**kwargs) -> None:
        """This task will fail if any upstream task fails."""
        ti = kwargs["ti"]
        print(ti.xcom_pull(key="state", task_ids="upload"))
        if ti.xcom_pull(key="state", task_ids="upload") == "FAILED":
            raise ValueError("Force failure because upstream task has failed")

    # Defining the tasks
    ini = start()
    E = download(disease)
    L = upload(disease)
    diagnosis = compare_tables_rows()
    clean = remove_parquets()
    end = done()

    # Task flow
    ini >> E >> L >> diagnosis >> clean >> end


def create_dag(
    disease: str,
    schedule: str,
    start: pendulum.datetime,
):
    """
    This method will be responsible for creating a DAG for a
    SINAN disease. It will receive the disease, its schedule
    and the start date, returning a DAG with the task flow.
    """
    sinan_tag = ["SINAN", "Brasil"]
    sinan_tag.append(disease)
    DEFAULT_ARGS.update(start_date=start)

    dag = DAG(
        "SINAN_" + DISEASES[disease],
        default_args=DEFAULT_ARGS,  # Tasks and Dags
        tags=sinan_tag,  # Only DAGs
        start_date=start,
        catchup=False,
        schedule_interval=schedule,
    )

    with dag:
        task_flow_for(disease)

    return dag


# DAGs
@dag(
    "SINAN_METADATA",
    default_args=DEFAULT_ARGS,
    tags=["SINAN", "Brasil", "Metadata"],
    start_date=pendulum.datetime(2022, 2, 1),
    catchup=False,
    schedule_interval="@once",
)
def metadata_tables():
    """
    This DAG will run only once and create a table in the
    database with each metadata found in the pysus SINAN
    disease metadata. It will not fail if a metadata is not
    available, only skip it.
    """

    @task(task_id="insert_metadata_tables")
    def metadata_tables():
        for disease in DISEASES:
            try:
                metadata_df = SINAN.metadata_df(disease)
                pd.DataFrame.to_sql(
                    metadata_df,
                    f"sinan_{normalize_str(disease)}_metadata",
                    con=ENG,
                    schema=SCHEMA,
                    if_exists="replace",
                )

                logger.info(f"Metadata table for {disease} updated.")
            except Exception:
                print(f"No metadata available for {disease}")

    meta = metadata_tables()
    meta


dag = metadata_tables()
# Here its where the DAGs are created, an specific case can be specified
for disease in DISEASES:
    # Change DAG variables here

    dag_id = "SINAN_" + DISEASES[disease]
    globals()[dag_id] = create_dag(
        disease,
        schedule="@monthly",
        start=pendulum.datetime(2022, 2, len(disease)),  # avoid memory overhead
    )
