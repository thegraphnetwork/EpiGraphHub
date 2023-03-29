"""
@author Luã Bida Vacaro | github.com/luabida
@date Last change on 2023-03-24

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
    This task will create the control table, which will be responsible for
    comparing the years for a disease in EGH SQL DB and the DBCs found on
    DataSUS FTP server. It stores the information about the stage of the
    year for the disease and when it was inserted.   

get_updates (PythonOperator):
    This task will compare the preliminary and final years between the data
    on EGH DB and the DBC files from the DataSUS FTP server. It will store
    as a dict which years should be updated, which should pass to final or 
    insert it for the first time.

extract (PythonOperator):
    This task will download every DBC from `get_updates` task as parquet.

first_insertion (PythonOperator):
    This task inserts every year from a SINAN disease that has not been found
    on EGH DB. 

prelims_to_finals (PythonOperator):
    This task will update the status for a year that have been passed from
    preliminary to final.

update_prelims (PythonOperator):
    This task will delete and re-insert the rows for every preliminary year
    and log the amount of new rows inserted into EGH DB.

all_done (PythonOperator):
    This task will remove every parquet extracted in the `extract` task.

end (EmptyOperator):
    The end of the Task Flow.
"""
import os
import pendulum
import psycopg2
import logging as logger
from datetime import timedelta

from airflow.decorators import task
from airflow.operators.empty import EmptyOperator

from epigraphhub.settings import env

DEFAULT_ARGS = {
    'owner': 'epigraphhub',
    'depends_on_past': False,
    'email': ['epigraphhub@thegraphnetwork.org'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 2,
    'retry_delay': timedelta(minutes=2),
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
    tablename = 'sinan_' + normalize_str(disease) + '_m'
    engine = get_engine(credential_name=env.db.default_credential)

    prelim_years = list(map(int, FTP_SINAN(disease).get_years('prelim')))
    finals_years = list(map(int, FTP_SINAN(disease).get_years('finais')))

    get_year = lambda file: int(str(file).split('.parquet')[0][-2:])
    
    upload_df = lambda df: df.to_sql(
        name=tablename, 
        con=engine.connect(), 
        schema=schema, 
        if_exists='append', 
        index=False
    )

    @task(task_id='start')
    def start_task():
        with engine.connect() as conn:
            conn.execute(
                f'CREATE TABLE IF NOT EXISTS {schema}.sinan_update_ctl ('
                ' disease TEXT NOT NULL,'
                ' year INT NOT NULL,'
                ' prelim BOOL NOT NULL,'
                ' last_insert DATE'
                ')'
            )

    @task(task_id='get_updates')
    def dbcs_to_fetch() -> dict:
        all_years = prelim_years + finals_years

        db_years = []
        with engine.connect() as conn:
            try:
                cur = conn.execute(
                    f'SELECT year FROM {schema}.sinan_update_ctl'
                    f" WHERE disease = '{disease}'"
                )
                years = cur.all()
            except Exception as e:
                if "UndefinedColumn" or "NoSuchTableError" in str(e):
                    years = []
            db_years.extend(list(chain(*years)))
        # Compare years found in ctl table with FTP server
        not_inserted = [y for y in all_years if y not in db_years]

        db_prelimns = []
        with engine.connect() as conn:
            try:
                cur = conn.execute(
                    f'SELECT year FROM {schema}.sinan_update_ctl'
                    f" WHERE disease = '{disease}' AND prelim IS True"
                )
                years = cur.all()
            except psycopg2.errors.lookup("42703"): #this is the UndefinedColumn code
                years = []
            db_prelimns.extend(list(chain(*years)))
        # Get years that are not prelim anymore
        prelim_to_final = [y for y in finals_years if y in db_prelimns]
        # Get prelims
        prelim_to_update = [y for y in prelim_years if y in db_prelimns]

        return dict(
            to_insert=not_inserted,
            to_finals=prelim_to_final,
            to_update=prelim_to_update,
        )

    @task(task_id='extract')
    def extract_parquets(**kwargs) -> dict:
        from epigraphhub.data.brasil.sinan import extract

        ti = kwargs['ti']
        years = ti.xcom_pull(task_ids='get_updates')

        extract_pqs = (
            lambda stage: extract.download(
                disease=disease, years=years[stage]
            ) if any(years[stage]) else ()
        )

        return dict(
            pqs_to_insert=extract_pqs('to_insert'),
            pqs_to_finals=extract_pqs('to_finals'),
            pqs_to_update=extract_pqs('to_update'),
        )

    @task(task_id='first_insertion', trigger_rule='all_done')
    def upload_not_inserted(**kwargs) -> dict:
        from pysus.online_data import parquets_to_dataframe

        ti = kwargs['ti']
        parquets = ti.xcom_pull(task_ids='extract')['pqs_to_insert']
        inserted_rows = dict()

        if not parquets:
            logger.info('There is no new DBCs to insert on DB')
            raise AirflowSkipException()

        finals, prelims = ([], [])
        for parquet in parquets:
            (
                finals.append(parquet)
                if get_year(parquet) in finals_years
                else prelims.append(parquet)
            )

        def insert_parquets(stage):
            parquets = finals or [] if stage == 'finals' else prelims or []
            prelim = False if stage == 'finals' else True

            for parquet in parquets:
                if not any(os.listdir(parquet)):
                    continue

                year = get_year(parquet)
                df = parquets_to_dataframe(str(parquet))

                if df.empty:
                    logger('DataFrame is empty')
                    continue

                df['year'] = year
                df['prelim'] = prelim
                df.columns = map(str.lower, df.columns)
                try:
                    upload_df(df)
                    logger.info(f'{parquet} inserted into db')
                except Exception as e:
                    if "UndefinedColumn" in str(e):
                        sql_dtypes = {
                            'int64': 'INT',
                            'float64': 'FLOAT',
                            'string': 'TEXT',
                            'object': 'TEXT',
                            'datetime64[ns]': 'TEXT',
                        }
                        
                        with engine.connect() as conn:
                            cur = conn.execute(
                                f'SELECT * FROM {schema}.{tablename} LIMIT 0'
                            )
                            tcolumns = cur.keys()

                        newcols = [c for c in df.columns if c not in tcolumns]

                        insert_cols_query = f'ALTER TABLE {schema}.{tablename}'
                        for column in newcols:
                            t = df[column].dtype
                            sqlt = sql_dtypes[str(t)]
                            add_col = f' ADD COLUMN {column} {str(sqlt)}'
                            if column == newcols[-1]:
                                add_col += ';'
                            else:
                                add_col += ','
                            insert_cols_query += add_col

                        with engine.connect() as conn:
                            conn.execute(insert_cols_query)
                    
                with engine.connect() as conn:
                    conn.execute(
                        f'INSERT INTO {schema}.sinan_update_ctl('
                        'disease, year, prelim, last_insert) VALUES ('
                        f"'{disease}', {year}, {prelim}, '{ti.execution_date}')"
                    )
                    cur = conn.execute(
                        f'SELECT COUNT(*) FROM {schema}.{tablename}'
                        f' WHERE year = {year}'
                    )
                    inserted_rows[str(year)] = cur.fetchone()[0]

        if finals:
            insert_parquets('finals')
        if prelims:
            insert_parquets('prelims')

        return inserted_rows

    @task(task_id='prelims_to_finals', trigger_rule='all_done')
    def update_prelim_to_final(**kwargs):
        from pysus.online_data import parquets_to_dataframe

        ti = kwargs['ti']
        parquets = ti.xcom_pull(task_ids='extract')['pqs_to_finals']

        if not parquets:
            logger.info(
                'Not found any prelim DBC that have been passed to finals'
            )
            raise AirflowSkipException()

        for parquet in parquets:
            if not any(os.listdir(parquet)):
                continue

            year = get_year(parquet)
            df = parquets_to_dataframe(parquet)

            if df.empty:
                logger.info('DataFrame is empty')
                continue

            df['year'] = year
            df['prelim'] = False
            df.columns = map(str.lower, df.columns)

            with engine.connect() as conn:
                conn.execute(
                    f'DELETE FROM {schema}.{tablename}'
                    f' WHERE year = {year}'
                    f' AND prelim = True'
                )

            upload_df(df)
            logger.info(f'{parquet} data updated from prelim to final.')

            with engine.connect() as conn:
                conn.execute(
                    f'UPDATE {schema}.sinan_update_ctl'
                    f" SET prelim = False, last_insert = '{ti.execution_date}'"
                    f" WHERE disease = '{disease}' AND year = {year}"
                )

    @task(task_id='update_prelims', trigger_rule='all_done')
    def update_prelim_parquets(**kwargs):
        from pysus.online_data import parquets_to_dataframe

        ti = kwargs['ti']
        parquets = ti.xcom_pull(task_ids='extract')['pqs_to_update']

        if not parquets:
            logger.info('No preliminary parquet found to update')
            raise AirflowSkipException()

        for parquet in parquets:
            if not any(os.listdir(parquet)):
                continue
            year = get_year(parquet)
            df = parquets_to_dataframe(parquet)

            if df.empty:
                logger.info('DataFrame is empty')
                continue

            df['year'] = year
            df['prelim'] = True
            df.columns = map(str.lower, df.columns)

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
                old_rows = cur.fetchone()[0]

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
                    f" SET last_insert = '{ti.execution_date}'"
                    f" WHERE disease = '{disease}' AND year = {year}"
                )

    @task(trigger_rule='all_done')
    def remove_parquets(**kwargs) -> None:
        import shutil
        """
        This task will be responsible for deleting all parquet files
        downloaded. It will receive the same parquet dirs the `upload`
        task receives and delete all them.
        """
        ti = kwargs['ti']
        pqts = ti.xcom_pull(task_ids='extract')

        parquet_dirs = list(
            chain(*(pqts['pqs_to_insert'], pqts['pqs_to_finals'], pqts['pqs_to_update']))
        )

        if not parquet_dirs:
            raise AirflowSkipException()

        for dir in parquet_dirs:
            shutil.rmtree(dir, ignore_errors=True)
            logger.warning(f'{dir} removed')

    end = EmptyOperator(
        task_id='done',
        trigger_rule='all_success',
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


# DAGs
# Here its where the DAGs are created, an specific case can be specified
from airflow.models.dag import DAG
from epigraphhub.data.brasil.sinan import DISEASES

from random import randint

for disease in DISEASES:
    dag_id = 'SINAN_' + DISEASES[disease]

    with DAG(
        dag_id=dag_id,
        default_args=DEFAULT_ARGS,
        tags=['SINAN', 'Brasil', disease],
        start_date=pendulum.datetime(
            2022, 2, randint(1,28)
        ),
        catchup=False,
        schedule='@monthly',
        dagrun_timeout=timedelta(minutes=10),
    ):
        task_flow_for(disease)
