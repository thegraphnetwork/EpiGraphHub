import pendulum

from datetime import timedelta
from airflow import DAG
from airflow.decorators import task


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
    from airflow.models import Variable

    CONN = Variable.get('egh_conn', deserialize_json=True)

    @task.external_python(
        task_id='first', 
        python='/opt/py311/bin/python3.11'
    )
    def update_dengue(egh_conn: dict):
        import logging

        from sqlalchemy import create_engine
        from pysus.online_data import parquets_to_dataframe
        from pysus.ftp.databases.sinan import SINAN

        sinan = SINAN().load()
        dis_code = "DENG"
        tablename = "sinan_dengue_m"
        files = sinan.get_files(dis_code=dis_code)

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
                cur = conn.execute(
                    f'SELECT COUNT(*) FROM brasil.{tablename}'
                    f' WHERE year = {year} AND prelim = False'
                )
                count = cur.fetchone()

            logging.info(f"Final year {year}: {count}")

            if not count:
                # Check on prelims
                with create_engine(egh_conn['URI']).connect() as conn:
                    cur = conn.execute(
                        f'SELECT COUNT(*) FROM brasil.{tablename}'
                        f' WHERE year = {year} AND prelim = True'
                    )
                    count = cur.fetchone()

                if count:
                    # Update prelim to final
                    cur = conn.execute(
                        f'DELETE FROM brasil.{tablename}'
                        f' WHERE year = {year} AND prelim = True'
                    )

                file = sinan.download(sinan.get_files(dis_code, year))

                df = parquets_to_dataframe(file.path)
                df['year'] = year
                df['prelim'] = False
                df.to_sql(
                    name=tablename, 
                    con=engine.connect(), 
                    schema=schema, 
                    if_exists='append', 
                    index=False
                )

        for year in f_stage['prelim']:
            with create_engine(egh_conn['URI']).connect() as conn:
                # Update prelim
                cur = conn.execute(
                    f'DELETE FROM brasil.{tablename}'
                    f' WHERE year = {year} AND prelim = True'
                )

            file = sinan.download(sinan.get_files(dis_code, year))

            df = parquets_to_dataframe(file.path)
            df['year'] = year
            df['prelim'] = True
            df.to_sql(
                name=tablename, 
                con=engine.connect(), 
                schema=schema, 
                if_exists='append', 
                index=False
            )

    update_dengue(CONN)
