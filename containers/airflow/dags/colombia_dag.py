import pendulum
import logging as logger
from datetime import timedelta
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import BranchPythonOperator
from epigraphhub.data.colombia import (
    loading,
    extract,
)


default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2022, 8, 26),
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=1),
}


@dag(
    schedule_interval="@daily",
    default_args=default_args,
    catchup=False,
)
def colombia():

    start = EmptyOperator(
        task_id="start",
    )

    done = EmptyOperator(
        task_id="done",
        trigger_rule="one_success",
    )

    def compare():
        if not extract.compare():
            logger.info("Proceeding to update positive_cases_covid_d.")
            return "not_updated"
        logger.info("Table positive_cases_covid_d up to date")
        return "up_to_date"

    outdated = EmptyOperator(
        task_id="not_updated",
    )
    updated = EmptyOperator(
        task_id="up_to_date",
    )

    check_dates = BranchPythonOperator(
        task_id="check_last_update",
        python_callable=compare,
    )

    @task(task_id="load_into_db", retries=2)
    def load():
        loading.upload()
        logger.info("Table positive_cases_covid_d updated.")

    start >> check_dates

    check_dates >> updated >> done
    check_dates >> outdated >> load() >> done


dag = colombia()
