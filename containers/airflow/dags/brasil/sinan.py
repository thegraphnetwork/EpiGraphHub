import shutil
import pendulum
import logging as logger
from pathlib import Path
from datetime import timedelta
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator

from epigraphhub.data.brasil.sinan import extract, loading
from epigraphhub.data._config import PYSUS_DATA_PATH
from epigraphhub.connection import get_engine
from epigraphhub.settings import env


default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2022, 12, 1),
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=2),
}


@dag(
    schedule_interval="@monthly",
    default_args=default_args,
    catchup=False,
    max_active_runs=2,
    max_active_tasks=2,
)
def brasil_sinan():
    """
    This DAG will fetch all diseases available on `diseases` from
    SINAN FTP server. Data will be downloaded at `/tmp/pysus` and then
    pushed into SQL database and the residues will be cleaned.
    @NOTE: This DAG can has a memory overhead that causes instability
           in Airflow System, therefore the max concurrency is set to 2.
    """

    engine = get_engine(credential_name=env.db.default_credential)
    diseases = extract.diseases

    def count_tables_rows() -> dict:
        """ 
        Counts table rows for each disease in diseases.
        """
        totals = {v: k for k, v in diseases.items()}
        with engine.connect() as conn:
            for disease in totals:
                try:
                    cur = conn.execute(f"SELECT COUNT(*) FROM brasil.{disease.lower()}")
                    rowcount = cur.fetchone()[0]
                    totals.update({disease:rowcount})
                except Exception as e:
                    if 'UndefinedTable' in str(e):
                        totals.update({disease:0})
                    else:
                        raise e
        return totals


    @task(task_id='start')
    def start() -> dict:
        return count_tables_rows()


    done = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )


    @task(task_id='extract', retries=3)
    def extract_data(disease) -> None:
        # Downloads an disease according to `diseases`.

        extract.download(disease)

        logger.info(f"Data for {disease} extracted")


    @task(task_id='upload')
    def upload_data() -> None:
        """
        This task will upload every disease in the directory /tmp/pysus
        that ends with `.parquet`, creating the corresponding table
        to each disease in `brasil` schema. 
        """        
        try:
            loading.upload()
        except Exception as e:
            logger.error(e)
            raise e


    @task(task_id='diagnosis')
    def compare_tables_rows(**kwargs) -> None:
        ti = kwargs['ti']
        ini_rows_amt = ti.xcom_pull(task_ids='start')
        end_rows_amt = count_tables_rows()
        
        for disease in ini_rows_amt:
            logger.info(
                f'{end_rows_amt[disease] - ini_rows_amt[disease]}'
                f' new rows inserted into brasil.{disease}'
            )


    @task(trigger_rule='all_done')
    def remove_data_dir() -> None:
        """ 
        Cleans /tmp/pysus data directory.
        """
        shutil.rmtree(PYSUS_DATA_PATH, ignore_errors=True)
        logger.warning(f'{PYSUS_DATA_PATH} removed')


    init = start()

    # `expand` will create a task for each disease/year.
    # There will be about 35 diseases total, each disease can
    # contain several years to fetch, setting `max_active_tasks`
    # to 2 will allow only two diseases to be downloading at 
    # the same time
    download = extract_data.expand(disease=list(diseases.keys()))
    
    upload = upload_data()

    diagnosis = compare_tables_rows()

    clean = remove_data_dir()

    init >> download >> upload >> diagnosis >> done >> clean


dag = brasil_sinan()
