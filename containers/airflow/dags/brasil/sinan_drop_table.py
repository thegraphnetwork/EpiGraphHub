import pendulum
import logging as logger

from datetime import timedelta

from airflow import DAG
from airflow.operators.python import PythonOperator

from epigraphhub.settings import env
from epigraphhub.connection import get_engine
from epigraphhub.data.brasil.sinan import (
    normalize_str,
)

DEFAULT_ARGS = {
    'owner': 'Admin',
    'depends_on_past': False,
    'email': ['epigraphhub@thegraphnetwork.org'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 2,
    'retry_delay': timedelta(minutes=2),
}

engine = get_engine(credential_name=env.db.default_credential)

with DAG(
    dag_id='SINAN_DROP_TABLE',
    default_args=DEFAULT_ARGS,
    tags=['SINAN', 'CTL'],
    start_date=pendulum.datetime(2023, 3, 27),
    catchup=False,
    schedule=None, #Only manually triggered 
    description='A DAG to delete a SINAN table in EGH db',
):
    def drop_tables(disease: str):
        dis = normalize_str(disease)
        tablename = 'sinan_' + dis + '_m'
        with engine.connect() as conn:
            conn.execute(
                f'DROP TABLE brasil.{tablename}'
            )
            logger.warn(f'Dropped table {tablename} on schema brasil')

    delete_tables_task = PythonOperator(
        task_id='drop_table',
        python_callable=drop_tables,
        op_kwargs={'disease': '{{ params.disease }}'},
        params={'disease': 'disease'},
    )

    delete_tables_task
