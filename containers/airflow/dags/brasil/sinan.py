import shutil
import pendulum
import pandas as pd
import logging as logger

from glob import glob
from pysus import SINAN
from pathlib import Path
from itertools import cycle
from datetime import timedelta

from airflow import DAG
from airflow.decorators import task, dag

from epigraphhub.settings import env
from epigraphhub.connection import get_engine
from epigraphhub.data._config import PYSUS_DATA_PATH
from epigraphhub.data.brasil.sinan import (
    extract,
    loading,
    DISEASES,
    normalize_str,
)

ENG = get_engine(credential_name=env.db.default_credential)
SCHEMA = 'brasil'
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

    tablename = 'sinan_' + normalize_str(disease) + '_m'

    def _count_table_rows() -> dict:
        """
        Counts table rows from brasil's Schema
        """
        with ENG.connect() as conn:
            try:
                cur = conn.execute(
                    f'SELECT COUNT(*) FROM {SCHEMA}.{tablename}'
                )
                rowcount = cur.fetchone()[0]
            except Exception as e:
                if 'UndefinedTable' in str(e):
                    return dict(rows=0)
                else:
                    raise e
        return dict(rows=rowcount)

    @task(task_id='start')
    def start() -> int:
        logger.info(f'ETL started for {disease}')
        return _count_table_rows()

    @task(task_id='extract', retries=3)
    def download(disease: str) -> list:
        extract.download(disease)
        logger.info(f'Data for {disease} extracted')
        parquet_dirs = glob(f'{Path(PYSUS_DATA_PATH)/DISEASES[disease]}*')
        return parquet_dirs

    @task(task_id='upload')
    def upload() -> None:
        try:
            loading.upload(disease, PYSUS_DATA_PATH)
        except Exception as e:
            logger.error(e)
            raise e

    @task(task_id='diagnosis')
    def compare_tables_rows(**kwargs) -> int:
        ti = kwargs['ti']
        ini_rows_amt = ti.xcom_pull(task_ids='start')
        end_rows_amt = _count_table_rows()

        new_rows = end_rows_amt['rows'] - ini_rows_amt['rows']

        logger.info(f'{new_rows} new rows inserted into brasil.{tablename}')

        ti.xcom_push(key='rows', value=ini_rows_amt['rows'])
        ti.xcom_push(key='new_rows', value=new_rows)

    @task(trigger_rule='all_done')
    def remove_parquets(**kwargs) -> None:
        ti = kwargs['ti']
        parquet_dirs = ti.xcom_pull(task_ids='extract')

        for dir in parquet_dirs:
            shutil.rmtree(dir, ignore_errors=True)
            logger.warning(f'{dir} removed')

    @task(trigger_rule='none_failed')
    def done(**kwargs) -> None:
        ti = kwargs['ti']
        print(ti.xcom_pull(key='state', task_ids='upload'))
        if ti.xcom_pull(key='state', task_ids='upload') == 'FAILED':
            raise ValueError('Force failure because upstream task has failed')

    ini = start()
    E = download(disease)
    L = upload()
    diagnosis = compare_tables_rows()
    clean = remove_parquets()
    end = done()

    ini >> E >> L >> diagnosis >> clean >> end


def create_dag(
    disease: str,
    schedule: str,
    start: pendulum.datetime,
):

    sinan_tag = ['SINAN', 'Brasil']
    sinan_tag.append(disease)
    DEFAULT_ARGS.update(start_date=start)

    dag = DAG(
        'SINAN_' + DISEASES[disease],
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
day = cycle(range(1, 29))


@dag(
    'SINAN_METADATA',
    default_args=DEFAULT_ARGS,
    tags=['SINAN', 'Brasil', 'Metadata'],
    start_date=pendulum.datetime(2022, 2, next(day)),
    catchup=False,
    schedule_interval='@once',
)
def metadata_tables():
    @task(task_id='insert_metadata_tables')
    def metadata_tables():
        for disease in DISEASES:
            try:
                metadata_df = SINAN.metadata_df(disease)
                pd.DataFrame.to_sql(
                    metadata_df,
                    f'sinan_{normalize_str(disease)}_metadata',
                    con=ENG,
                    schema=SCHEMA,
                    if_exists='replace',
                )

                logger.info(f'Metadata table for {disease} updated.')
            except Exception:
                print(f'No metadata available for {disease}')

    meta = metadata_tables()
    meta


dag = metadata_tables()

for disease in DISEASES:
    # Change DAG variables here

    dag_id = 'SINAN_' + DISEASES[disease]
    globals()[dag_id] = create_dag(
        disease,
        schedule='@monthly',
        start=pendulum.datetime(2022, 2, next(day)),
    )
