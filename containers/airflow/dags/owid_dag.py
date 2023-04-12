"""
@author Luã Bida Vacaro | github.com/luabida
@date Last change on 2022-10-24

This is an Airflow DAG. This DAG is responsible for running scripts for
collecting data from Our World in Data (OWID). The API that fetches the
data is available on https://github.com/thegraphnetwork/epigraphhub_py/.
A detailed article about the Airflow used on EpiGraphHub can be found
at our website https://www.epigraphhub.org/ or EGH's GitHub Pages:
https://github.com/thegraphnetwork/thegraphnetwork.github.io.

Base Workflow
-------------
                                 ┌──────┐   ┌────────────┐
                             ┌──►│upload├──►│update_index├──┐
┌────────┐    ┌────────────┐ │   └──────┘   └────────────┘  │   ┌────┐
│download├───►│compare_size├─┤                              ├──►│done│
└────────┘    └────────────┘ │               ┌────────┐     │   └────┘
                             └──────────────►│continue├─────┘
                                             └────────┘

(Graph generated using https://asciiflow.com/)

Task Summary
------------

start (EmptyOperator) :
    This task does nothing. Used for representing the start of the flow.

download_data (PythonOperator) :
    This task runs the command for downloading the OWID CSV file.

is_same_shape (BranchPythonOperator) :
    This branch will decide which task should run next based on the result
    of the evaluation on `comp_data()`.

same_shape (EmptyOperator) :
    This empty task also does nothing. A task instance is required for
    continuing the flow after the branching.

not_same_shape (EmptyOperator) :
    This empty task also does nothing. A task instance is required for
    continuing the flow after the branching. If the evaluation is False
    the DAG will proceed to update the database.

load_into_db (PythonOperator) :
    This task follows `not_same_shape` and updates the database with the
    data from the CSV file with `{...}data_collection.owid.load_into_db()`

parse_index (PythonOperator)  :
    Update missing index on `owid_covid` table.

done (EmptyOperator) :
    This task does nothing. Used for representing that the update flow has
    finish successfully.

remove_csv (PythonOperator) :
    This task will remove the OWID CSV file recursively.
"""
import pendulum
import logging as logger
from datetime import timedelta
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import BranchPythonOperator
from epigraphhub.data.owid import extract, transform, loading


default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2022, 8, 23),
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=1),
}


@dag(
    schedule="@daily",
    default_args=default_args,
    catchup=False,
    tags=['OWID']
)
def owid():
    """
    This method represents the DAG itself using the @dag decorator. The method
    has to be instantiated so the Scheduler can recognize as a DAG. OWID DAG
    will be responsible for running data_collection scripts from epigraphhub_py
    api and update the Postgres Database every day.

    Arguments
    ---------

    owner (str)             : The DAG's owner. Only the owner or admin can
                              view or run this DAG.
    depends_on_past (bool)  : If set to True, a task fail will stop
                              further tasks and future DAGs to run until
                              be fixed or manually ran.
    start_date (pendulum)   : When the DAG is ran for the first time.
    email (str)             : Email for failing reports.
    email_on_failure (bool) : If a task fails, an email will be sent.
    email_on_retry (bool)   : An email will be sent every retry attempt.
    retries (int)           : How many times a task should retry if it
                              fails.
    retry_delay (timedelta) : The delay between each retry.
    schedule_interval (str) : The interval between each DAG run. DAG uses
                              CRON syntax too ("* * * * *").
    default_args (dict)     : The same arguments can be passed to
                              different DAGs using default_args.
    catchup (bool)          : If set to True, the DAG will look for past
                              dates to backfill the data if data
                              collection is configured correctly.
                              @warning Not available for OWID.

    Methods
    -------

    download_owid()  : Method responsible for executing the script from
                       epigraphhub_py API to download the CSV file from OWID
                       dataset and stores it in the OWID's temporary directory

    comp_data()      : Used for comparing the SQL Database with the downloaded
                       CSV file, evaluates the shapes from both and returns
                       the string that corresponds the next task to be run.

    insert_into_db() : Used in `load_into_db` task to run epigraphhub_py
                       Python Script to connect and update the rows of
                       `owid_covid` SQL table.

    parse_index()    : Create location, iso_code and date indexes if they are
                       missing in the CSV file.
    """
    start = EmptyOperator(
        task_id="start",
    )

    @task(task_id="download_data")
    def download_owid():
        extract.download()
        logger.info("OWID CSV downloaded")

    def comp_data():
        """
        Returns:
            not_same_shape (str) : If evaluation is False, returns the string
                                   corresponding with the task for update SQL
                                   table.
            same_shape (str)     : If evaluation is True, returns the string
                                   corresponding to the task that ends the
                                   workflow. No update is needed.
        """
        try:
            match_data_size = extract.compare()
            if not match_data_size:
                logger.info(f"Table owid_covid needs update.")
                logger.info(f"Proceeding to update table owid_covid.")
                return "not_same_shape"
        except:
            return "not_same_shape"
        logger.info("Table owid_covid up to date.")
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

    @task(task_id="load_into_db")
    def insert_into_db():
        loading.upload(remote=False)
        logger.info("Table owid_covid updated.")

    @task(task_id="update_index")
    def parse_index():
        transform.parse_indexes(remote=False)
        logger.info("location, iso_code and date indexes updated.")

    @task(task_id="delete_csv")
    def remove_csv():
        extract.remove()
        logger.info("OWID CSV removed.")

    """
    Task Dependencies
    -----------------

    This area defines the task dependencies. A task depends on
    another one if followed by a right bit shift (>>). A Branch
    task will be branched if more than one task is defined as its
    dependency and merged using a common empty task.
    """
    start >> download_owid() >> branch

    branch >> same_shape >> done
    branch >> not_same_shape >> insert_into_db() >> parse_index() >> done

    done >> remove_csv()


dag = owid()
