import pendulum
from datetime import timedelta
from airflow.decorators import dag, task
from airflow.operators.python import BranchPythonOperator
from airflow.operators.empty import EmptyOperator
from epigraphhub.data.data_collection.owid import download_data, compare_data, load_into_db


default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2022, 8, 23),
    'email': ['epigraphhub@thegraphnetwork.org'],
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
def owid():

    start = EmptyOperator(
        task_id="start",
    )

    @task(task_id="download_data", retries=2)
    def download_owid():
        download_data.download_csv()

    def comp_data(same_shape=True):
        db_shape = compare_data.database_size(remote=False)
        csv_shape = compare_data.csv_size()
        same_shape = eval("db_shape == csv_shape")
        if not same_shape:
            return "not_same_shape"
        return "same_shape"

    branch = BranchPythonOperator(
        task_id="is_same_shape",
        python_callable=comp_data,
    )

    not_same_shape = EmptyOperator(
        task_id="not_same_shape",
    )
    same_shape = EmptyOperator(
        task_id="same_shape",
    )
    done = EmptyOperator(
        task_id="done",
        trigger_rule="one_success",
    )

    @task(task_id="load_into_db", retries=2)
    def insert_into_db():
        load_into_db.load(remote=False)

    @task(task_id="delete_csv")
    def remove_csv():
        download_data.remove_csv()

    start >> download_owid() >> branch

    branch >> same_shape >> done
    branch >> not_same_shape >> insert_into_db() >> done

    done >> remove_csv()


dag = owid()
