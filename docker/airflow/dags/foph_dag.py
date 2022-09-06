import pendulum
from datetime import timedelta
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator, BranchPythonOperator
from epigraphhub.data.data_collection.foph import (
    download_data,
    compare_data,
    load_into_db,
)


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
    schedule_interval="@weekly",
    default_args=default_args,
    catchup=False,
)
def foph():

    start = EmptyOperator(
        task_id="start",
    )

    end = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    tables = [[t, u] for t, u in download_data.get_csv_relation()]

    def download(url):
        download_data.download_csv(url)

    def compare(tablename, url):
        db_last_update = compare_data.table_last_update(tablename)
        filename = str(url).split("/")[-1]
        csv_last_update = compare_data.csv_last_update(filename)
        print(db_last_update)
        print(csv_last_update)
        compare_dates = eval("db_last_update == csv_last_update")
        if not compare_dates:
            return f"{tablename}_need_update"
        return f"{tablename}_up_to_date"

    def load_to_db(table, url):
        filename = str(url).split("/")[-1]
        load_into_db.load(table, filename)

    @task(trigger_rule="all_done")
    def remove_csv_dir():
        download_data.remove_csvs()

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

    clean = remove_csv_dir()
    end >> clean


dag = foph()
