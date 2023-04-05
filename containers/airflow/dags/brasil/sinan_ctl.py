import pendulum
import logging as logger

from datetime import timedelta

from airflow import DAG
from airflow.decorators import task
from epigraphhub.data.brasil.sinan import FTP_SINAN

from epigraphhub.settings import env
from epigraphhub.connection import get_engine
from epigraphhub.data.brasil.sinan import (
    DISEASES,
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

engine = get_engine(credential_name=env.db.default_credential)

with DAG(
    dag_id='SINAN_UPDATE_CTL',
    default_args=DEFAULT_ARGS,
    tags=['SINAN', 'CTL'],
    start_date=pendulum.datetime(2023, 4, 1, 12, 30),
    catchup=False,
    schedule='@daily',
    description='A DAG to update the SINAN control table in EGH db',
):

    schema = 'brasil'
    tablename ='sinan_update_ctl'

    @task(task_id='start')
    def start_task():
        with engine.connect() as conn:
            conn.execute(
                f'CREATE TABLE IF NOT EXISTS {schema}.{tablename} ('
                ' disease TEXT NOT NULL,'
                ' year INT NOT NULL,'
                ' path TEXT NOT NULL,'
                ' prelim BOOL NOT NULL,'
                ' to_final BOOL NOT NULL DEFAULT False,'
                ' last_insert DATE'
                ')'
            )

    @task(task_id='update_ctl_table')
    def update_table():
        for disease in DISEASES.keys():
            dis = FTP_SINAN(disease)

            prelim_years = list(map(int, dis.get_years('prelim')))
            finals_years = list(map(int, dis.get_years('finais')))
            prelim_paths = dis.get_ftp_paths(prelim_years)
            finals_paths = dis.get_ftp_paths(finals_years)

            for year, path in zip(prelim_years, prelim_paths):
                if not year: continue
                with engine.connect() as conn:
                    cur = conn.execute(
                        f'SELECT prelim FROM {schema}.{tablename}'
                        f" WHERE disease = '{disease}' AND year = {year}"
                    )
                    prelim = cur.fetchone()
                
                if prelim is None:
                    with engine.connect() as conn:
                        conn.execute(
                            f'INSERT INTO {schema}.{tablename} ('
                            f'disease, year, path, prelim) VALUES ('
                            f"'{disease}', {year}, '{path}', True)"
                            )
                        logger.debug(f'Insert {disease} {year} {path}')

            for year, path in zip(finals_years, finals_paths):
                if not year: continue
                with engine.connect() as conn:
                    cur = conn.execute(
                        f'SELECT prelim FROM {schema}.{tablename}'
                        f" WHERE disease = '{disease}' AND year = {year}"
                    )
                    prelim = cur.fetchone()
                
                if prelim is None:
                    with engine.connect() as conn:
                        conn.execute(
                            f'INSERT INTO {schema}.{tablename} ('
                            f'disease, year, path, prelim) VALUES ('
                            f"'{disease}', {year}, '{path}', True)"
                        )
                        logger.debug(f'Insert {disease} {year} {path}')
                
                elif prelim[0] is False:
                    with engine.connect() as conn:
                        conn.execute(
                            f'UPDATE {schema}.{tablename} SET'
                            f" prelim = False, to_final = True, path = '{path}'"
                            f" WHERE disease = '{disease}' AND year = {year}"
                        )
                        logger.debug(f'Update to final {disease} {year} {path}')

    start = start_task()
    update = update_table()

    start >> update
