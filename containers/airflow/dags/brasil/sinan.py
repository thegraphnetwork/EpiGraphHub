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

from datetime import timedelta
from pysus.online_data import SINAN

from airflow import DAG
from airflow.decorators import task, dag

from epigraphhub.settings import env
from epigraphhub.connection import get_engine
from epigraphhub.data.brasil.sinan import (
    FTP_SINAN,
    extract,
    loading,
    DISEASES,
    normalize_str,
)

ENG = get_engine(credential_name=env.db.default_credential)
SCHEMA = "brasil"
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

    tablename = "sinan_" + normalize_str(disease) + "_m"

    def _count_table_rows() -> dict:
        """
        Counts table rows from brasil's Schema
        """
        with ENG.connect() as conn:
            try:
                cur = conn.execute(f"SELECT COUNT(*) FROM {SCHEMA}.{tablename}")
                rowcount = cur.fetchone()[0]
            except Exception as e:
                if "UndefinedTable" in str(e):
                    return dict(rows=0)
                else:
                    raise e
        return dict(rows=rowcount)

    @task(task_id="start")
    def start() -> int:
        """
        Task to start the workflow, will read the database and return
        the rows count for a SINAN disease.
        """
        logger.info(f"ETL started for {disease}")
        return _count_table_rows()

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
