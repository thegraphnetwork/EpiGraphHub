"""
@author Luã Bida Vacaro | github.com/luabida
@date Last change on 2023-10-05

NOTE: This DAG is a modified copy of foph DAG to fetch weekly data.
      FOPH stopped updating the daily dataset for Covid in 2023,
      therefore the original DAG has been disabled and this DAG
      took its place, keeping the same workflow with minor changes.
"""
import pendulum

from datetime import timedelta
from airflow import DAG
from airflow.decorators import task
from airflow.models import TaskInstance
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import ExternalPythonOperator, BranchExternalPythonOperator


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


with DAG(
    dag_id='FOPH_WEEKLY',
    tags = ['CHE', 'FOPH', 'Switzerland'],
    schedule='@weekly',
    default_args=default_args,
    catchup=False,
) as dag:
    start = EmptyOperator(
        task_id="start",
    )

    end = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    @task.external_python(
        task_id='get_tables', python='/opt/py310/bin/python3.10'
    )
    def get_tables():
        from epigraphhub.data.foph import extract
        tables_default = [[f'{t}_w', u] for t, u in extract.fetch(freq='weekly')]
        tables_by_age = [[f'{t}_byage_w', u] for t, u in extract.fetch(freq='weekly', by='age')]
        tables_by_sex = [[f'{t}_bysex_w', u] for t, u in extract.fetch(freq='weekly', by='sex')]

        tables = tables_default + tables_by_age + tables_by_sex


    def download(url):
        import logging as logger
        from epigraphhub.data.foph import extract
        extract.download(url)
        logger.info(f"{str(url).split('/')[-1]} downloaded.")

    def compare(tablename, url):
        import logging as logger
        from epigraphhub.data.foph import loading
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
        import logging as logger
        from epigraphhub.data.foph import loading
        filename = str(url).split("/")[-1]
        loading.upload(table, filename)
        logger.info(f"foph_{table} updated.")

    def parse_table(table):
        import logging as logger
        from epigraphhub.data.foph import transform
        transform.parse_date_region(table)
        logger.info(f"geoRegion and date index updated on foph_{table.lower()}")

    @task.external_python(
        task_id='all_done', python='/opt/py310/bin/python3.10'
    )
    def remove_csv_dir():
        import logging as logger
        from epigraphhub.data.foph import extract
        extract.remove(entire_dir=True)
        logger.info("CSVs directory removed.")


    for table in tables:
        tablename, url = table

        down = ExternalPythonOperator(
            task_id=tablename,
            python_callable=download,
            op_kwargs={"url": url},
            python='/opt/py310/bin/python3.10'
        )

        comp = BranchExternalPythonOperator(
            task_id=f"comp_{tablename}",
            python_callable=compare,
            op_kwargs={"tablename": tablename, "url": url},
            python='/opt/py310/bin/python3.10'
        )

        not_same_shape = EmptyOperator(
            task_id=f"{tablename}_need_update",
        )
        same_shape = EmptyOperator(
            task_id=f"{tablename}_up_to_date",
        )

        load = ExternalPythonOperator(
            task_id=f"load_{tablename}",
            python_callable=load_to_db,
            op_kwargs={"table": tablename, "url": url},
            python='/opt/py310/bin/python3.10'
        )

        parse = ExternalPythonOperator(
            task_id=f"parse_{tablename}",
            python_callable=parse_table,
            op_kwargs={"table": tablename},
            python='/opt/py310/bin/python3.10'
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
