import sys
import pendulum
from datetime import timedelta

DATA_PATH = "/opt/EpiGraphHub/data_collection"
sys.path.insert(0, DATA_PATH)
from foph.download_foph_data import get_csv_relation, download_csv
from foph.foph_fetch import load_into_db, csv_size, table_size

from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator, BranchPythonOperator


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
    schedule_interval="@weekly",
    default_args=default_args,
    catchup=False,
    template_searchpath=DATA_PATH,
)
def foph():

    start = EmptyOperator(
        task_id="start",
    )

    end = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    tables = [[t, u] for t, u in get_csv_relation()]

    def download(url):
        download_csv(url)

    def compare(tablename, url):
        db_shape = table_size(tablename)
        filename = str(url).split("/")[-1]
        csv_shape = csv_size(filename)
        print(f'Table on DB size: {db_shape}')
        print(f'CSV size: {csv_shape}')
        same_shape = eval("db_shape == csv_shape")
        if not same_shape:
            return f"{tablename}_need_update"
        return f"{tablename}_up_to_date"

    def load_to_db(table, url):
        filename = str(url).split("/")[-1]
        load_into_db(table, filename)

    for table in tables:
        tablename, url = table

        down = PythonOperator(
            task_id=tablename,
            python_callable=download,
            provide_context=True,
            op_kwargs={"url": url},
        )

        comp = BranchPythonOperator(
            task_id=f"comp_{tablename}",
            python_callable=compare,
            provide_context=True,
            op_kwargs={"tablename": tablename, "url": url},
        )

        not_same_shape = EmptyOperator(
            task_id=f"{tablename}_need_update",
        )
        same_shape = EmptyOperator(
            task_id=f"{tablename}_up_to_date",
        )

        load = PythonOperator(
            task_id=f"load_{tablename}",
            python_callable=load_to_db,
            provide_context=True,
            op_kwargs={"table": tablename, "url": url},
        )

        done = EmptyOperator(
            task_id=f"table_{tablename}_done",
            trigger_rule="one_success",
        )

        start >> down >> comp
        comp >> same_shape >> done >> end
        comp >> not_same_shape >> load >> done >> end


dag = foph()
