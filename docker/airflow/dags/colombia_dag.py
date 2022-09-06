from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import BranchPythonOperator
import pendulum
from datetime import timedelta
from epigraphhub.data.data_collection.colombia import compare_data, load_chunks_into_db


default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2022, 8, 26),
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
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
        table_last_upd = compare_data.table_last_update()
        api_last_upd = compare_data.api_last_update()
        same_shape = eval("table_last_upd == api_last_upd")
        if not same_shape:
            return "not_updated"
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
    def load_chunks_in_db():
        load_chunks_into_db.gen_chunks_into_db()

    start >> check_dates

    check_dates >> updated >> done
    check_dates >> outdated >> load_chunks_in_db() >> done


dag = colombia()
