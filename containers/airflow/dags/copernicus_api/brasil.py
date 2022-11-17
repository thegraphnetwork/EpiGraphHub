import os
import pendulum
import calendar
import pandas as pd
import logging as logger

from tqdm import tqdm
from pathlib import Path
from datetime import timedelta, datetime

from airflow.decorators import dag
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator

from satellite_weather_downloader import extract_reanalysis
from satellite_weather_downloader.utils import extract_latlons, connection


# 3rd-party postgres connection (InfoDengue)
from sqlalchemy import create_engine
from dotenv import dotenv_values

dotenv = Path(__file__).resolve().parent / ".env"
cds_config = dotenv_values(dotenv)

PSQL_USER = cds_config["COPE_POSTGRES_USER"]
PSQL_PASSWORD = cds_config["COPE_POSTGRES_PASSWORD"]
HOST = cds_config["COPE_POSTGRES_HOST"]
PORT = cds_config["COPE_POSTGRES_PORT"]
DBASE = cds_config["COPE_POSTGRES_DATABASE"]
UUID = cds_config["COPE_API_UUID"]
KEY = cds_config["COPE_API_KEY"]

engine = create_engine(
    f"postgresql://{PSQL_USER}:{PSQL_PASSWORD}@{HOST}:{PORT}/{DBASE}"
)


default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2000, 2, 1),
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}


# Stablish Copernicus User Connection
connection.connect(UUID, KEY)


@dag(
    schedule_interval="@monthly",
    default_args=default_args,
    catchup=True,
)
def cope_weather_brasil():

    start = EmptyOperator(
        task_id="start",
    )

    done = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    def extract(exec_date) -> str:

        pdate = datetime.strptime(exec_date, "%Y-%m-%d")

        # Copernicus API can't handle dates in the current month
        # with last month's days. Adding a safety margin to never
        # use the current month.
        if pdate.month == 1:
            year = pdate.year - 1
            month = 12
            iday, eday = calendar.monthrange(year, month)

            ini_date = datetime(year, month, 1)
            end_date = datetime(year, month, eday)

        else:
            year = pdate.year
            month = pdate.month - 1
            iday, eday = calendar.monthrange(year, month)

            ini_date = datetime(year, month, 1)
            end_date = datetime(year, month, eday)

        netcdf_file = extract_reanalysis.download_netcdf(
            date=ini_date.strftime("%Y-%m-%d"),
            date_end=end_date.strftime("%Y-%m-%d"),
            data_dir="/tmp",
        )

        return netcdf_file

    def upload(file: str):

        geocodes = [mun["geocodigo"] for mun in extract_latlons.municipios]

        cope_df = pd.DataFrame(
            columns=[
                "date",
                "geocodigo",
                "temp_min",
                "temp_med",
                "temp_max",
                "precip_min",
                "precip_med",
                "precip_max",
                "pressao_min",
                "pressao_med",
                "pressao_max",
                "umid_min",
                "umid_med",
                "umid_max",
            ]
        )

        total_cities = 5570
        with tqdm(total=total_cities) as pbar:
            for geocode in geocodes:
                row = extract_reanalysis.netcdf_to_dataframe(file, geocode)
                cope_df = cope_df.merge(row, on=list(cope_df.columns), how="outer")
                pbar.update(1)

        cope_df = cope_df.set_index("date")

        cope_df.to_sql(
            "weather_copernicus",
            engine,
            schema="Municipio",
            if_exists="append",
        )

        logger.info(f'{len(cope_df)} rows updated on "Municipios".weather_copernicus')

    def remove(file: str):

        Path(file).unlink()

        logger.info(f'{file.split("/")[-1]} removed.')

    fetch = PythonOperator(
        task_id="extract",
        python_callable=extract,
        provide_context=True,
        op_kwargs={
            "exec_date": "{{ ds }}",
        },
        do_xcom_push=True,
    )

    load = PythonOperator(
        task_id="load",
        python_callable=upload,
        provide_context=True,
        op_kwargs={
            "file": "{{ ti.xcom_pull(task_ids='extract') }}",
        },
    )

    clean = PythonOperator(
        task_id="clean",
        python_callable=remove,
        provide_context=True,
        op_kwargs={
            "file": "{{ ti.xcom_pull(task_ids='extract') }}",
        },
    )

    start >> fetch >> load >> clean >> done


dag = cope_weather_brasil()
