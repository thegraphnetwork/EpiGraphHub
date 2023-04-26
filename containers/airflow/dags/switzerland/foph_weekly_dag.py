"""
@author Luã Bida Vacaro | github.com/luabida
@date Last change on 2023-04-18

NOTE: This DAG is a modified copy of foph DAG to fetch weekly data.
      FOPH stopped updating the daily dataset for Covid in 2023,
      therefore the original DAG has been disabled and this DAG
      took its place, keeping the same workflow with minor changes.
"""
import pendulum
import logging as logger

from datetime import timedelta
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator, BranchPythonOperator

from epigraphhub.data.foph import (
    extract,
    loading,
    transform,
)


default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2023, 1, 1),
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=1),
}


@dag(
    schedule='@weekly',
    default_args=default_args,
    catchup=False,
    tags = ['CHE', 'FOPH', 'Switzerland'],
    max_active_tasks=6
)
def FOPH_WEEKLY():
    start = EmptyOperator(
        task_id="start",
    )

    end = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    tables_default = [[f'{t}_w', u] for t, u in extract.fetch(freq='weekly')]
    tables_by_age = [[f'{t}_byage_w', u] for t, u in extract.fetch(freq='weekly', by='age')]
    tables_by_sex = [[f'{t}_bysex_w', u] for t, u in extract.fetch(freq='weekly', by='sex')]

    tables = tables_default + tables_by_age + tables_by_sex

    def download(url):
        extract.download(url)
        logger.info(f"{str(url).split('/')[-1]} downloaded.")

    def compare(tablename, url):
        filename = str(url).split("/")[-1]

        try:
            equal = loading.compare(filename, tablename)
            if not equal:
                logger.info(f"Proceeding to update foph_{tablename}.")
                return f"{tablename}_need_update"
        except:
            logger.info(f"Table not found, proceeding to update foph_{tablename}.")
            return f"{tablename}_need_update"
        logger.info(f"foph_{tablename} is up to date.")
        return f"{tablename}_up_to_date"

    def load_to_db(table, url):
        filename = str(url).split("/")[-1]
        loading.upload(table, filename)
        logger.info(f"foph_{table} updated.")

    def parse_table(table):
        transform.parse_date_region(table)
        logger.info(f"geoRegion and date index updated on foph_{table.lower()}")

    @task(trigger_rule="all_done")
    def remove_csv_dir():
        extract.remove(entire_dir=True)
        logger.info("CSVs directory removed.")

    for table in tables:
        tablename, url = table

        down = PythonOperator(
            task_id=tablename,
            python_callable=download,
            op_kwargs={"url": url},
        )

        comp = BranchPythonOperator(
            task_id=f"comp_{tablename}",
            python_callable=compare,
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
            op_kwargs={"table": tablename, "url": url},
        )

        parse = PythonOperator(
            task_id=f"parse_{tablename}",
            python_callable=parse_table,
            op_kwargs={"table": tablename},
        )

        done = EmptyOperator(
            task_id=f"table_{tablename}_done",
            trigger_rule="one_success",
        )

        """
        Task Dependencies
        -----------------

        This area defines the task dependencies. A task depends on
        another one if followed by a right bit shift (>>). A Branch
        task will be branched if more than one task is defined as its
        dependency and merged using a common empty task.
        All tasks inside this loop will become a individually task with
        its own workflow, based on the `tablename`.
        """
        start >> down >> comp
        comp >> same_shape >> done >> end
        comp >> not_same_shape >> load >> parse >> done >> end

    clean = remove_csv_dir()
    end >> clean

dag = FOPH_WEEKLY()
