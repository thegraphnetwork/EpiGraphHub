import os
import time

import psycopg2
from pathlib import Path

from dotenv import load_dotenv
from pandas.io.sql import get_schema
import pandas as pd
import psycopg2.extras as extras
import pyarrow.parquet as pq
from sqlalchemy import create_engine

from pysus.online_data.SINAN import download

load_dotenv()
env_path = Path(".") / ".env"
load_dotenv(dotenv_path=env_path)


db_config = {
    "database": os.getenv('POSTGRES_EPIGRAPH_DB'),
    "user": os.getenv('POSTGRES_USER'),
    "password": os.getenv('POSTGRES_PASSWORD'),
    "host": os.getenv('POSTGRES_HOST'),
    "port": os.getenv('POSTGRES_PORT'),
}

PSQL_URI = "postgresql://{}:{}@{}:{}/{}".format(
    db_config.get('user'),
    db_config.get('password'),
    db_config.get('host'),
    db_config.get('port'),
    db_config.get('database'),

)

engine = create_engine(PSQL_URI)
conn = psycopg2.connect(**db_config)

st = time.time()


def parquet_to_df(fname: str) -> pd.DataFrame:
    """
    Read columns from pyarrowParquet into a Pandas DataFrame.

    Parameters
    ----------
        fname: str
    Returns
    -------
        dataframe: pandas
    """
    df = (
        pq.ParquetDataset(f'{fname}/', use_legacy_dataset=False, )
        .read_pandas() #columns=COL_NAMES
        .to_pandas()
    )

    elapsed_time = time.time() - st
    print(
        'Get data from PySUS to {}, finished in: {}'.format(fname,
            time.strftime("%H:%M:%S", time.gmtime(elapsed_time))
            ))

    return df


def insert_into_postgres(
    df: pd.DataFrame, schema: str, table:str) -> conn.commit:
    """
    Delete the table if it exists and create a new table 
    according to the disease name and year.
    Adds dataframe data to table.
    Parameters
    ----------
        df: pandas, schema: schema name, table: table name
    Returns
    -------
        commit: Execute query with psycopg2.extras
    """
    df.columns= df.columns.str.lower()
    table_name = f"{schema}.{table}"
    schema_metadata = get_schema(df, table, schema=schema, con=engine)

    with conn.cursor(cursor_factory=extras.DictCursor) as cursor:
        sql = f'''
            DROP TABLE IF EXISTS {table_name};
            {schema_metadata};
            '''
        cursor.execute(sql)
        conn.commit()

    with conn.cursor(cursor_factory=extras.DictCursor) as cursor:
        tuples = [tuple(x) for x in df.to_numpy()]
        cols = ", ".join(list(df.columns))
        insert_sql = "INSERT INTO %s(%s) VALUES %%s" % (table_name, cols)
        try:
            extras.execute_values(cursor, insert_sql, tuples)
            conn.commit()

            elapsed_time = time.time() - st
            print(
                'Pysus: {} rows in {} fields inserted in the database, finished at: {}'.format(
                df.shape[0], df.shape[1], time.strftime("%H:%M:%S", time.gmtime(elapsed_time))))

        except Exception as e:
            print(e)


if __name__ == '__main__':
    fname = download(2017,'zika', return_fname=True)    
    fname_pq = Path(f'./{fname}')
    schema='brasil'
    table = f"{fname[:-8].lower()}"
    
    insert_into_postgres(parquet_to_df(fname_pq), schema, table)
