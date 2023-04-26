"""
@author Luã Bida Vacaro | github.com/luabida
@date Last change on 2023-04-18

This DAG is responsible for fetching and updating metadata tables
for FOPH daily and weekly data. If metadata already exists in DB,
it will delete the table and re-insert it. 
"""
import pendulum
import logging as logger
import pandas as pd

from datetime import timedelta
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator

from epigraphhub.data.foph import extract
from epigraphhub.connection import get_engine
from epigraphhub.settings import env

default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2023, 1, 1),
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=1),
}


@dag(
    schedule='@monthly',
    default_args=default_args,
    catchup=False,
    tags = ['Metadata', 'CHE', 'FOPH', 'Switzerland'],
    max_active_tasks=6
)
def FOPH_METADATA():
    start = EmptyOperator(
        task_id="start",
    )

    end = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    tables_d = [
        [
            f'foph_{str(t).lower()}_d_meta', 
            str(u).split('/')[-1][:-4]
        ] 
        for t, u 
        in extract.fetch()
    ] # Daily tables
    tables_default_w = [
        [
            f'foph_{str(t).lower()}_w_meta', 
            str(u).split('/')[-1][:-4]
        ] 
        for t, u 
        in extract.fetch(freq='weekly')
    ] # Weekly default tables
    tables_by_age_w = [
        [
            f'foph_{str(t).lower()}_byage_w_meta', 
            str(u).split('/')[-1][:-4]
        ] 
        for t, u 
        in extract.fetch(freq='weekly', by='age')
    ] # Weekly by age tables
    tables_by_sex_w = [
        [
            f'foph_{str(t).lower()}_bysex_w_meta', 
            str(u).split('/')[-1][:-4]
        ] 
        for t, u 
        in extract.fetch(freq='weekly', by='sex')
    ] # Weekly by sex tables

    tables = tables_d + tables_default_w + tables_by_age_w + tables_by_sex_w
    
    def extract_metadata(filename) -> pd.DataFrame:
        # Creates the dataframe extracting the metadata from the API
        df = extract.metadata(filename=filename)
        properties = df[df.columns[0]]['properties']
        data = list()
        for column, info in properties.items():
            try:
                metadata = dict()
                metadata['column_name'] = column
                metadata['type'] = info['type']
                metadata['description'] = info['description']
                data.append(metadata)
            except KeyError:
                # Incompatible metadata column
                continue
        return pd.DataFrame(data)
    
    def load_to_db(tablename: str, dataframe: pd.DataFrame) -> None:
        # Inserts metadata dataframe into DB
        engine = get_engine(env.db.default_credential)

        with engine.connect() as conn:
            dataframe.to_sql(
                name=tablename,
                con=conn,
                schema='switzerland',
                if_exists='replace'
            )
        logger.info(f"{tablename} updated.")

    @task(task_id='load_metadata')
    def load_metadata_tables():
        logger.info(f'Going to update: {[t[0] for t in tables]}')
        # Loops through all tables
        for table in tables:
            tablename, filename = table
            df = extract_metadata(filename)
            load_to_db(tablename, df)
        logger.info('Done')
    
    load = load_metadata_tables()

    start >> load >> end

dag = FOPH_METADATA()
