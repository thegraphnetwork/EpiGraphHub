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
        package. The task will fetch for all 
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

        
        def insert_parquets(parquet_dir: str, year: int):
            """
            Insert parquet dir into database using its chunks. Delete the chunk
            and the directory after insertion.
            """
            for parquet in os.listdir(parquet_dir):
                file = os.path.join(parquet_dir, parquet)
                df = pd.read_parquet(str(file), engine='fastparquet')
                df.columns = df.columns.str.lower()
                df['year'] = year
                df['prelim'] = False
                df.to_sql(
                    name=tablename, 
                    con=create_engine(egh_conn['URI']), 
                    schema="brasil", 
                    if_exists='append', 
                    index=False
                )
                del df
                os.remove(file)
                logging.debug(f"{file} inserted into db")
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

                try:
                    insert_parquets(parquets.path, year)
                except ProgrammingError as error:
                    if str(error).startswith("(psycopg2.errors.UndefinedColumn)"):
                        # Include new columns to table
                        column_name = str(error).split('"')[1]
                        with create_engine(egh_conn['URI']).connect() as conn:
                            conn.execute(text(
                                f'ALTER TABLE brasil.{tablename}'
                                f' ADD COLUMN {column_name} TEXT'
                            ))
                            conn.commit()
                        logging.warning(f"Column {column_name} added into {tablename}")
                        insert_parquets(parquets.path, year)

                os.rmdir(parquets.path)

        for year in f_stage['prelim']:
            with create_engine(egh_conn['URI']).connect() as conn:
                # Update prelim
                cur = conn.execute(text(
                    f'DELETE FROM brasil.{tablename}'
                    f" WHERE year = '{year}' AND prelim = True"
                ))

            parquets = sinan.download(sinan.get_files(dis_code, year))

            try:
                insert_parquets(parquets.path, year)
            except ProgrammingError as error:
                if str(error).startswith("(psycopg2.errors.UndefinedColumn)"):
                    # Include new columns to table
                    column_name = str(error).split('"')[1]
                    with create_engine(egh_conn['URI']).connect() as conn:
                        conn.execute(text(
                            f'ALTER TABLE brasil.{tablename}'
                            f' ADD COLUMN {column_name} TEXT'
                        ))
                        conn.commit()
                    logging.warning(f"Column {column_name} added into {tablename}")
                    insert_parquets(parquets.path, year)

            os.rmdir(parquets.path)

    update_dengue(CONN)
