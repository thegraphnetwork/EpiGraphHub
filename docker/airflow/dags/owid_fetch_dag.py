from airflow.decorators import dag, task
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator
import pendulum
from datetime import timedelta

DATA_PATH = "/opt/EpiGraphHub/data_collection"
import sys
sys.path.insert(0, DATA_PATH)
from owid import download_data, compare_data

default_args = {
    'owner': 'epigraphhub',
    'depends_on_past': False,
    'start_date': pendulum.datetime(2022, 8, 23), 
    #'email': [''],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=1)
}

@dag(schedule_interval='@daily', 
     default_args=default_args,
     catchup=False, 
     template_searchpath=DATA_PATH
     )
def owid():

    start = EmptyOperator(
        task_id='start',
    )

    @task(task_id='download_data', retries=2)
    def download_owid():
        download_data.download_csv()

    @task(task_id='compare_data', retries=2)
    def get_shapes():
        db_shape = compare_data.database_size(remote=False)
        csv_shape = compare_data.csv_size()
        same_shape = eval("db_shape == csv_shape")
        print(f'db: {db_shape}      csv: {csv_shape}      eval:{same_shape}')
        
        

    start >> download_owid() >> get_shapes()

dag = owid()
