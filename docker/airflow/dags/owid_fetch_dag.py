from airflow.decorators import dag
from airflow.operators.bash import BashOperator
import pandas as pd
from datetime import datetime

@dag(schedule_interval='@daily', 
     start_date=datetime(2022, 8, 23), 
     catchup=False, 
     template_searchpath='/opt/EpiGraphHub/Data_Collection/CRON_scripts'
     )
def execute_owid():

    execute_owid_script = BashOperator(
        task_id="execute_owid_sh",
        bash_command="owid.sh"
    )

    execute_owid_script

dag = execute_owid()
