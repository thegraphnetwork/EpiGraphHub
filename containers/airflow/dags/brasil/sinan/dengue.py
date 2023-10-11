import pendulum

from datetime import timedelta
from airflow import DAG
from airflow.decorators import task
from airflow.models import Variable


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

with DAG(
    dag_id='SINAN_DENG',
    tags=['SINAN', 'Brasil', 'Dengue'],
    schedule='@monthly',
    default_args=default_args,
    catchup=False,
) as dag:

    CONN = Variable.get('egh_conn', deserialize_json=True)

    @task.external_python(
        task_id='update_dengue', 
        python='/opt/py311/bin/python3.11'
    )
    def update_dengue(egh_conn: dict):
        """
        This task will run in an isolated python environment, containing PySUS
        package. The task will fetch for all Dengue years from DATASUS and insert
        them into EGH database
        """
        import os
        import logging
        import pandas as pd

        from sqlalchemy import create_engine, text
        from sqlalchemy.exc import ProgrammingError
        from pysus.online_data import parquets_to_dataframe
        from pysus.ftp.databases.sinan import SINAN

        sinan = SINAN().load()
        dis_code = "DENG"
        tablename = "sinan_dengue_m"
        files = sinan.get_files(dis_code=dis_code)


        def to_sql_include_cols(df: pd.DataFrame, engine):
            """
            Insert dataframe into db, include missing columns if needed
            """
            df.columns = df.columns.str.lower()

            with create_engine(egh_conn['URI']).connect() as conn:
                # Get columns
                res = conn.execute(text(f'SELECT * FROM brasil.{tablename} LIMIT 1'))
                sql_columns = set(i[0] for i in res.cursor.description)

            df_columns = set(df.columns)
            columns_to_add = df_columns.difference(sql_columns)

            if columns_to_add:
                sql_statements = [f"ALTER TABLE {tablename}"]
                for column in columns_to_add:
                    sql_statements.append(f"ADD COLUMN {column} TEXT,") # object

                with create_engine(egh_conn['URI']).connect() as conn:
                    sql = ' '.join(sql_statements)
                    logging.warning(f"EXECUTING: {sql}")
                    conn.execute(text(sql))
                    conn.commit()

            df.to_sql(
                name=tablename, 
                con=engine, 
                schema="brasil", 
                if_exists='append', 
                index=False
            )

        def insert_parquets(parquet_dir: str, year: int):
            """
            Insert parquet dir into database using its chunks. Delete the chunk
            and the directory after insertion
            """
            for parquet in os.listdir(parquet_dir):
                file = os.path.join(parquet_dir, parquet)
                df = pd.read_parquet(str(file), engine='fastparquet')
                df['year'] = year
                df['prelim'] = False

                to_sql_include_cols(df, create_engine(egh_conn['URI']))
                logging.debug(f"{file} inserted into db")

                del df
                os.remove(file)
            os.rmdir(parquets.path)


        f_stage = {}
        for file in files:
            code, year = sinan.format(file)
            stage = 'prelim' if 'PRELIM' in file.path else 'final'

            if not stage in f_stage:
                f_stage[stage] = [year]
            else:
                f_stage[stage].append(year)

        for year in f_stage['final']:
            # Check if final is already in DB
            with create_engine(egh_conn['URI']).connect() as conn:
                cur = conn.execute(text(
                    f'SELECT COUNT(*) FROM brasil.{tablename}'
                    f" WHERE year = '{year}' AND prelim = False"
                ))
                count = cur.fetchone()[0]

            logging.info(f"Final year {year}: {count}")

            if not count:
                # Check on prelims
                with create_engine(egh_conn['URI']).connect() as conn:
                    cur = conn.execute(text(
                        f'SELECT COUNT(*) FROM brasil.{tablename}'
                        f" WHERE year = '{year}' AND prelim = True"
                    ))
                    count = cur.fetchone()[0]

                if count:
                    # Update prelim to final
                    cur = conn.execute(text(
                        f'DELETE FROM brasil.{tablename}'
                        f" WHERE year = '{year}' AND prelim = True"
                    ))

                parquets = sinan.download(sinan.get_files(dis_code, year))
                insert_parquets(parquets.path, year)

        for year in f_stage['prelim']:
            with create_engine(egh_conn['URI']).connect() as conn:
                # Update prelim
                cur = conn.execute(text(
                    f'DELETE FROM brasil.{tablename}'
                    f" WHERE year = '{year}' AND prelim = True"
                ))

            parquets = sinan.download(sinan.get_files(dis_code, year))
            insert_parquets(parquets.path, year)

    update_dengue(CONN)
