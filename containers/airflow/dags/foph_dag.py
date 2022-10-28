"""
@author Luã Bida Vacaro | github.com/luabida
@date Last change on 2022-10-24

This is an Airflow DAG. This DAG is responsible for running scripts for
collecting data from Federal Office of Public Health (FOPH). The API
that fetches the data is available on:
https://github.com/thegraphnetwork/epigraphhub_py/.
A detailed article about the Airflow used in EpiGraphHub can be found
at our website https://www.epigraphhub.org/ or EGH's GitHub Pages:
https://github.com/thegraphnetwork/thegraphnetwork.github.io.

Base Workflow
-------------

             create one task
             for each CSV to
             run in parallel                  ┌────┐   ┌────────────┐
                   │                       ┌─►│load├──►│update_index├─┐
┌───────────────┐  │ ┌────────┐   ┌───────┐│  └────┘   └────────────┘ │  ┌────┐
│csv_relation[n]├──┴►│download├──►│compare├┤                          ├─►│done│
└─────────────┬─┘    └────────┘   └───────┘│               ┌────────┐ │  └────┘
              │                            └──────────────►│continue├─┘
              │                                            └────────┘
              │
       `n` as the number of
       CSV files to download,
       where each one will
       become a task

(Graph generated using https://asciiflow.com/)

Task Summary
------------

start (EmptyOperator) :
    This task does nothing. Used for representing the start of the flow.

down (PythonOperator) :
    This task runs the command for downloading all CSVs found in FOPH URL.

comp (BranchPythonOperator) :
    This branch will decide which task should run next based on the result
    of the evaluation on `compare(tablename, url)`.

same_shape (EmptyOperator) :
    This empty task also does nothing. A task instance is required for
    continuing the flow after the branching.

not_same_shape (EmptyOperator) :
    This empty task also does nothing. A task instance is required for
    continuing the flow after the branching. If the evaluation is False
    the DAG will proceed to update the database.

load (PythonOperator) :
    This task follows `not_same_shape` and updates the database with the
    data from each CSV file with `{...}data.foph.load()`

parse (PythonOperator) :
    Update `geoRegion` and `date` indices if missing in each table.

end (EmptyOperator) :
    This task does nothing. Used for representing that the update flow has
    finish successfully. Marked as success only if all dependencies ran
    successfully.

remove_csv_dir (PythonOperator) :
    This task will remove the FOPH CSV directory recursively.
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
    "start_date": pendulum.datetime(2022, 8, 26),
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=1),
}


@dag(
    schedule_interval="@weekly",
    default_args=default_args,
    catchup=False,
)
def foph():
    """
    This method represents the DAG itself using the @dag decorator. The method
    has to be instantiated so the Scheduler can recognize as a DAG. FOPH DAG
    will be responsible for running data_collection scripts from epigraphhub_py
    api and update the Postgres Database every week.
    As this DAG contains a for loop, every iteration will represent different
    tasks instances. The loop goes through the content found by the method
    `get_csv_relation()` and it is stored in `tables` as a dictionary of URLs
    and table names, each entry will then have their own tasks as defined inside
    the for loop.

    Arguments
    ---------
    Every task will inherit the arguments, using some of them. E.g. retries.

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
                              @warning Not available for FOPH DAG.

    Methods
    -------

    get_csv_relation()      : This method will retrieve the CSV relation for
                              each file to be downloaded and stores as an dict

    download(url)           : Method responsible for executing the script from
                              epigraphhub_py API to download the CSV file from
                              each URL in dict `tables`

    compare(tablename, url) : Used for comparing dates from SQL Database with
                              the downloaded CSV file, evaluates the max date
                              found on both and returns the string that
                              corresponds the next task to be run.

    load_to_db(table, url)  : Used in `load_into_db` task to run epigraphhub_py
                              Python Script to connect and update the rows of
                              each table on `tables` into its respective SQL
                              table.

    parse_table(table)      : Create location, iso_code and date indices if
                              missing in the CSV file.
    """
    start = EmptyOperator(
        task_id="start",
    )

    end = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    tables = [[t, u] for t, u in extract.fetch()]

    def download(url):
        """
        Downloads the CSV file as specified in the url argument.

        Args:
            url (str) : URL of the CSV file to be downloaded.
        """
        extract.download(url)
        logger.info(f"{str(url).split('/')[-1]} downloaded.")

    def compare(tablename, url):
        """
        Used for comparing the maximum date found on the CSV file and in
        the SQL table, respectively. Evaluate the datetimes and returns
        the string that corresponds to the next task to be run.

        Args:
            tablename (str) : Name of the table to be queried in the database
            url (str)       : URL of the CSV as specified in `tables` dict

        Returns:
            {...}_need_update (str) : This string corresponds to the task that
                                      will be run if the evaluation is False
            {...}_up_to_date (str)  : If the evaluation is True, return a string
                                      that corresponds to a task to be run next,
                                      which indicates the table is already up to
                                      date.
        """
        filename = str(url).split("/")[-1]

        if not loading.compare(filename, tablename):
            logger.info(f"Proceeding to update foph_{tablename}_d.")
            return f"{tablename}_need_update"

        logger.info(f"foph_{tablename}_d is up to date.")
        return f"{tablename}_up_to_date"

    def load_to_db(table, url):
        """
        Connects to the SQL Database and load the CSV content for its respective
        table.

        Args:
            tablename (str) : Name of the table to be updated
            url (str)       : URL of the CSV as specified in `tables` dict
        """
        filename = str(url).split("/")[-1]
        loading.upload(table, filename)
        logger.info(f"foph_{table}_d updated.")

    def parse_table(table):
        """
        Connects to the table and update `geoRegion` and `date` index if they are
        missing.

        Args:
            tablename (str) : Name of the table in the SQL Database
        """
        transform.parse_date_region(table)
        logger.info(f"geoRegion and date index updated on foph_{table.lower()}_d")

    @task(trigger_rule="all_done")
    def remove_csv_dir():
        """
        This method represents a task itself using a @task decorator. It will be
        responsible for deleting the CSV directory recursively.

        Args:
            trigger_rule (str) : With this task argument, the task will only be
                                 triggered after all dependencies finish their
                                 runs, returning rather fail or success.
        """
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


dag = foph()
