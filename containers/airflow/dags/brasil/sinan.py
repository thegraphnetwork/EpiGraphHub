import shutil
import pendulum
import logging as logger

from glob import glob
from pathlib import Path
from itertools import cycle
from datetime import timedelta

from airflow import DAG
from airflow.decorators import task
from airflow.operators.empty import EmptyOperator

from epigraphhub.settings import env
from epigraphhub.connection import get_engine
from epigraphhub.data._config import PYSUS_DATA_PATH
from epigraphhub.data.brasil.sinan import extract, loading, DISEASES


ENG = get_engine(credential_name=env.db.default_credential)
SCHEMA = 'brasil'
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
    def _count_table_rows(engine, table: str) -> int:
        """ 
        Counts table rows from brasil's Schema
        """
        with engine.connect() as conn:
            try:
                cur = conn.execute(f"SELECT COUNT(*) FROM {SCHEMA}.{table}")
                rowcount = cur.fetchone()[0]
            except Exception as e:
                if 'UndefinedTable' in str(e):
                    return 0
                else:
                    raise e
        return rowcount

    @task(task_id='start')
    def start(disease: str) -> int:
        logger.info(f'ETL started for {disease}')
        return _count_table_rows(ENG, DISEASES[disease].lower())

    @task(task_id='extract', retries=3)
    def download(disease: str) -> list:
        extract.download(disease)
        logger.info(f"Data for {disease} extracted")
        parquet_dirs = glob(f'{Path(PYSUS_DATA_PATH)/DISEASES[disease]}*')
        return parquet_dirs

    @task(task_id='upload')
    def upload(**kwargs) -> None:
        ti = kwargs['ti']
        parquet_dirs = ti.xcom_pull(task_ids='extract')
        try:
            loading.upload(parquet_dirs)
        except Exception as e:
            logger.error(e)
            raise e

    @task(task_id='diagnosis')
    def compare_tables_rows(disease: str, **kwargs) -> int:
        ti = kwargs['ti']
        ini_rows_amt = ti.xcom_pull(task_ids='start')
        end_rows_amt = _count_table_rows(ENG, DISEASES[disease].lower())
        
        new_rows = end_rows_amt - ini_rows_amt

        logger.info(
            f'{new_rows} new rows inserted into brasil.{disease}'
        )

        return new_rows

    @task(trigger_rule='all_done')
    def remove_parquets(**kwargs) -> None:
        ti = kwargs['ti']
        parquet_dirs = ti.xcom_pull(task_ids='extract')
        
        for dir in parquet_dirs:
            shutil.rmtree(dir, ignore_errors=True)
            logger.warning(f'{dir} removed')

    done = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    ini = start(disease)
    E = download(disease)
    L = upload()
    diagnosis = compare_tables_rows(disease)
    clean = remove_parquets()
    end = done

    ini >> E >> L >> diagnosis >> clean >> end


def create_dag(
    disease: str,
    schedule: str,
    start: pendulum.datetime,
):

    sinan_tag = ['SINAN']
    sinan_tag.append(disease)

    dag = DAG(
        'SINAN_' + DISEASES[disease],
        default_args=DEFAULT_ARGS,
        tags = sinan_tag,
        start_date=start,
        catchup=False,
        schedule_interval=schedule
    )

    with dag:
        task_flow_for(disease)

    return dag


# DAGs
day = cycle(range(1, 29))
for disease in DISEASES:
    # Change DAG variables here

    dag_id = 'SINAN_' + DISEASES[disease]
    globals()[dag_id] = create_dag(
        disease,
        schedule='@monthly',
        start=pendulum.datetime(2022, 2, next(day))
    )
