from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
import pendulum
from datetime import timedelta

DATA_PATH = "/opt/EpiGraphHub/data_collection"
import sys

sys.path.insert(0, DATA_PATH)
from colombia import load_chunks_into_db
from config import COLOMBIA_SOC


default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2022, 8, 26),
    #'email': [''],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=1),
}


@dag(
    schedule_interval="@daily",
    default_args=default_args,
    catchup=False,
    template_searchpath=DATA_PATH,
)
def colombia():

    start = EmptyOperator(
        task_id="start",
    )

    @task(task_id="load_into_db", retries=2)
    def load_chunks_in_db(client=COLOMBIA_SOC):
        load_chunks_into_db.gen_chunks_into_db(client)

    start >> load_chunks_in_db()


dag = colombia()
