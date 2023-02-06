import shutil
import pendulum
import logging as logger
from pathlib import Path
from datetime import timedelta
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator

from epigraphhub.data.brasil.sinan import extract, loading


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
    SINAN FTP server. Data will be downloaded at `$HOME/pysus` and then
    pushed into SQL database and the residues will be cleaned.
    @NOTE: This DAG can has a memory overhead that causes instability
           in Airflow System, therefore the max concurrency is set to 2.
    """

    diseases = extract.diseases

    start = EmptyOperator(
        task_id="start",
    )

    done = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    @task(task_id='extract', retries=3)
    def extract_data(disease):
        # Downloads an disease according to `diseases`.

        extract.download(disease)

        logger.info(f"Data for {disease} extracted")


    @task(task_id='upload')
    def upload_data():
        """
        This task will upload every disease in the directory ~/pysus
        that ends with `.parquet`, creating the corresponding table
        to each disease in `brasil` schema. 
        """        
        try:
            loading.upload()
        except Exception as e:
            logger.error(e)
            raise e

    @task(trigger_rule='all_done')
    def remove_data_dir():
        """ 
        Cleans ~/pysus data directory.
        """
        pysus_data = Path.home() / 'pysus'
        shutil.rmtree(pysus_data, ignore_errors=True)
        logger.warning(f'{pysus_data} removed')


    # `expand` will create a task for each disease/year.
    # There will be about 35 diseases total, each disease can
    # contain several years to fetch, setting `max_active_tasks`
    # to 2 will allow only two diseases to be downloading at 
    # the same time
    download = extract_data.expand(disease=list(diseases.keys()))
    
    upload = upload_data()

    clean = remove_data_dir()

    start >> download >> upload >> done >> clean


dag = brasil_sinan()
