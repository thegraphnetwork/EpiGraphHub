import pendulum
import pandas as pd
import logging as logger

from datetime import timedelta
from pysus.online_data import SINAN
from airflow.decorators import task, dag

from epigraphhub.settings import env
from epigraphhub.connection import get_engine
from epigraphhub.data.brasil.sinan import (
    DISEASES,
    normalize_str,
)

DEFAULT_ARGS = {
    'owner': 'epigraphhub',
    'depends_on_past': False,
    'email': ['epigraphhub@thegraphnetwork.org'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 2,
    'retry_delay': timedelta(minutes=2),
}


@dag(
    'SINAN_METADATA',
    default_args=DEFAULT_ARGS,
    tags=['SINAN', 'Brasil', 'Metadata'],
    start_date=pendulum.datetime(2022, 2, 1),
    catchup=False,
    schedule='@once',
)
def metadata_tables():
    """
    This DAG will run only once and create a table in the
    database with each metadata found in the pysus SINAN
    disease metadata. It will not fail if a metadata is not
    available, only skip it.
    """

    engine = get_engine(credential_name=env.db.default_credential)

    @task(task_id='insert_metadata_tables')
    def metadata_tables():
        for disease in DISEASES:
            try:
                metadata_df = SINAN.metadata_df(disease)
                pd.DataFrame.to_sql(
                    metadata_df,
                    f'sinan_{normalize_str(disease)}_metadata',
                    con=engine,
                    schema='brasil',
                    if_exists='replace',
                )

                logger.info(f'Metadata table for {disease} updated.')
            except Exception:
                print(f'No metadata available for {disease}')

    meta = metadata_tables()
    meta


dag = metadata_tables()
