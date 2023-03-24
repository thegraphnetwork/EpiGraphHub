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
import pendulum
import logging as logger
from datetime import timedelta
from psycopg2.errors import UndefinedColumn

from airflow.decorators import task
from airflow.operators.empty import EmptyOperator

from epigraphhub.settings import env

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
    from itertools import chain
    from epigraphhub.connection import get_engine
    from airflow.exceptions import AirflowSkipException
    from epigraphhub.data.brasil.sinan import FTP_SINAN, normalize_str

    schema = 'brasil'
    tablename = "sinan_" + normalize_str(disease) + "_m"
    engine = get_engine(credential_name=env.db.default_credential)

    prelim_years = list(map(int, FTP_SINAN(disease).get_years('prelim')))
    finals_years = list(map(int, FTP_SINAN(disease).get_years('finais')))

    get_year = lambda file: int(str(file).split('.parquet')[0][-2:])
    
    upload_df = lambda df: df.to_sql(
            name=tablename,
            con=engine.connect(),
            schema=schema,
            if_exists='append'
        )

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
            try:
                cur = conn.execute(
                    f'SELECT year FROM {schema}.sinan_update_ctl'
                    f' WHERE disease = "{disease}"'
                )
                years = cur.all()
            except UndefinedColumn:
                years = []
            db_years.extend(list(chain(*years)))
        not_inserted = [y for y in all_years if y not in db_years]

        db_prelimns = []
        with engine.connect() as conn:
            try:
                cur = conn.execute(
                    f'SELECT year FROM {schema}.sinan_update_ctl'
                    f' WHERE disease = "{disease}" AND prelim IS True'
                )
                years = cur.all()
            except UndefinedColumn:
                years = []
            db_years.extend(list(chain(*years)))
            
        prelim_to_final = [y for y in finals_years if y in db_prelimns]
        prelim_to_update = [y for y in prelim_years if y in db_prelimns]

        return dict(
            to_insert = not_inserted,
            to_finals = prelim_to_final,
            to_update = prelim_to_update
        )

    @task(task_id="extract")
    def extract_parquets(**kwargs) -> dict:
        from epigraphhub.data.brasil.sinan import extract

        ti = kwargs["ti"]
        years = ti.xcom_pull(task_ids="get_updates")

        extract_pqs = lambda stage: extract.download(
            disease=disease, years=years[stage]
            ) if any(years[stage]) else ()

        return dict(
            pqs_to_insert = extract_pqs('to_insert'),
            pqs_to_finals = extract_pqs('to_finals'),
            pqs_to_update = extract_pqs('to_update')
        )
    
    @task(task_id='first_insertion')
    def upload_not_inserted(**kwargs) -> dict:
        from epigraphhub.data.brasil.sinan import viz

        ti = kwargs["ti"]
        parquets = ti.xcom_pull(task_ids="extract")['pqs_to_insert']
        inserted_rows = dict()
        
        if not parquets:
            logger.info('There is no new DBCs to insert on DB')
            raise AirflowSkipException()

        finals, prelims = ([], [])
        for parquet in parquets:
            (
                finals.append(parquet) 
                if get_year(parquet) in finals_years 
                else prelims.append(get_year(parquet))
            )
        
        for final_pq in (finals or []):
            year = get_year(final_pq)
            df = viz.parquet(final_pq)
            if df.empty:
                raise ValueError('DataFrame is empty')
            df['year'] = (year)
            df['prelim'] = (False)
            upload_df(df)
            logger.info(f'{final_pq} inserted into db')
            with engine.connect() as conn:
                conn.execute(
                    f'INSERT INTO {schema}.sinan_update_ctl('
                    'disease, year, prelim, last_insert) VALUES ('
                    f'{disease}, {year}, False, {ti.execution_date})'
                )
                cur = conn.execute(
                    f'SELECT COUNT(*) FROM {schema}.{tablename}'
                    f' WHERE year = {year}'
                )
                inserted_rows[year] = cur.fetchone[0]

        for prelim_pq in prelims or []:
            year = get_year(prelim_pq)
            df = viz.parquet(prelim_pq)
            if df.empty:
                raise ValueError('DataFrame is empty')
            df['year'] = (year)
            df['prelim'] = (True)
            upload_df(df)
            logger.info(f'{prelim_pq} inserted into db')
            with engine.connect() as conn:
                conn.execute(
                    f'INSERT INTO {schema}.sinan_update_ctl('
                    'disease, year, prelim, last_insert) VALUES ('
                    f'{disease}, {year}, True, {ti.execution_date})'
                )
                cur = conn.execute(
                    f'SELECT COUNT(*) FROM {schema}.{tablename}'
                    f' WHERE year = {year}'
                )
                inserted_rows[year] = cur.fetchone[0]
        
        return inserted_rows

    @task(task_id='prelims_to_finals')
    def update_prelim_to_final(**kwargs):
        from epigraphhub.data.brasil.sinan import viz

        ti = kwargs["ti"]
        parquets = ti.xcom_pull(task_ids="extract")['pqs_to_finals']

        if not parquets:
            logger.info(
                'Not found any prelim DBC that have been passed to finals'
            )
            raise AirflowSkipException()
        
        for parquet in parquets:
            year = get_year(parquet)
            df = viz.parquet(parquet)
            if df.empty:
                raise ValueError('DataFrame is empty')
            df['year'] = (year)
            df['prelim'] = (False)

            with engine.connect() as conn:
                conn.execute(
                    f'DELETE FROM {schema}.{tablename}'
                    f' WHERE year = {year}'
                    f' AND prelim = True'
                )
            
            upload_df(df)
            logger.info(
                f'{parquet} data updated from prelim to final.'
            )

            with engine.connect() as conn:
                conn.execute(
                    f'UPDATE {schema}.sinan_update_ctl'
                    f' SET prelim = False, last_insert = {ti.execution_date}'
                    f' WHERE disease = "{disease}" AND year = {year}'
                )

    @task(task_id='update_prelims')
    def update_prelim_parquets(**kwargs):
        from epigraphhub.data.brasil.sinan import viz

        ti = kwargs["ti"]
        parquets = ti.xcom_pull(task_ids="extract")['pqs_to_update']

        if not parquets:
            logger.info('No preliminary parquet found to update')
            raise AirflowSkipException()    

        for parquet in parquets:
            year = get_year(parquet)
            df = viz.parquet(parquet)
            if df.empty:
                raise ValueError('DataFrame is empty')
            df['year'] = (year)
            df['prelim'] = (True)

            with engine.connect() as conn:
                cur = conn.execute(
                    f'SELECT COUNT(*) FROM {schema}.{tablename}'
                    f' WHERE year = {year}'
                )
                conn.execute(
                    f'DELETE FROM {schema}.{tablename}'
                    f' WHERE year = {year}'
                    f' AND prelim = True'
                )
                old_rows = cur.fetchone[0]
            
            upload_df(df)
            logger.info(
                f'{parquet} data updated'
                '\n~~~~~ '
                f'\nRows inserted: {len(df)}'
                f'\nNew rows: {len(df) - int(old_rows)}'
                '\n~~~~~ '
            )

            with engine.connect() as conn:
                conn.execute(
                    f'UPDATE {schema}.sinan_update_ctl'
                    f' SET last_insert = {ti.execution_date}'
                    f' WHERE disease = "{disease}" AND year = {year}'
                )

    @task(trigger_rule="all_done")
    def remove_parquets(**kwargs) -> None:
        import shutil
        """
        This task will be responsible for deleting all parquet files
        downloaded. It will receive the same parquet dirs the `upload`
        task receives and delete all them.
        """
        ti = kwargs["ti"]
        pqts = ti.xcom_pull(task_ids="extract")

        parquet_dirs = list(
            chain(*(pqts['to_insert'], pqts['to_finals'], pqts['to_update']))
        )

        for dir in parquet_dirs:
            shutil.rmtree(dir, ignore_errors=True)
            logger.warning(f"{dir} removed")


    end = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    # Defining the tasks
    ini = start_task()
    dbcs = dbcs_to_fetch()
    E = extract_parquets()
    upload_new = upload_not_inserted()
    to_final = update_prelim_to_final()
    prelims = update_prelim_parquets()
    clean = remove_parquets()

    # Task flow
    ini >> dbcs >> E >> upload_new >> to_final >> prelims >> clean >> end


from epigraphhub.data.brasil.sinan import DISEASES

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
    from airflow import DAG

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
        dagrun_timeout=timedelta(minutes=10)
    )

    with dag:
        task_flow_for(disease)

    return dag


# DAGs
# Here its where the DAGs are created, an specific case can be specified
for disease in DISEASES:
    # Change DAG variables here

    dag_id = "SINAN_" + DISEASES[disease]
    globals()[dag_id] = create_dag(
        disease,
        schedule="@monthly",
        start=pendulum.datetime(2022, 2, len(disease)),  # avoid memory overhead
    )
