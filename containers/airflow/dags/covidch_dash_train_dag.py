"""
@author Eduardo Araujo
@date Last change on 2022-10-31
The ability of triggering a DAG based on a External Successful Task.
Task Summary
------------
wait_for_foph (ExternalTaskSensor) :
    This task will be triggered when the task `done` on the DAG `foph` is
    marked as successful.
    @note: `schedule_interval` needs to match the `foph` interval.
    @note: `execution_date_fn` is the time window the task should sensor
           for a external event.
start (EmptyOperator) :
    This task does nothing. Used for representing the start of the flow.
end (EmptyOperator) :
    This task does nothing. Used for representing that the update flow has 
    finish successfully. Marked as success only if all dependencies ran
    successfully.
"""
from datetime import timedelta
import pendulum
import logging as logger
from airflow.models import DagRun
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.sensors.external_task import ExternalTaskSensor
from scripts.dashboards.covid_ch.for_swiss import train_all_cantons
from sqlalchemy import create_engine
from scripts.dashboards.covid_ch.config import PATH

default_args = {
    "owner": "epigraphhub",
    "depends_on_past": False,
    "start_date": pendulum.datetime(2022, 8, 26, 0, 0),
    "email": ["epigraphhub@thegraphnetwork.org"],
    "email_on_failure": False,  # TODO: Set to True before merge
    "email_on_retry": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=1),
}


@dag(
    schedule_interval=timedelta(days =60),
    default_args=default_args,
    catchup=False,
)
def train_covidch():
    """
    This method represents the DAG itself using the @dag decorator. The method
    has to be instantiated so the Scheduler can recognize as a DAG. train_covidch
    will be responsible to train and save the models that will be used in the UPDATE_COVIDCH dag.
    This method must run after the FOPH DAG, but every two months, not weekly. 

    Methods
    -------

    train_new_hosp()   :Train the models to forecast new hospitalizations. The models will be save in the `PATH`
                        folder defined in the ./scripts/dashboards/covid_ch/config.py script.

    train_total_hosp() :Train the models to forecast total hospitalizations. The models will be save in the `PATH`
                        folder defined in the ./scripts/dashboards/covid_ch/config.py script.

    train_total_icu()  :Train the models to forecast total icu. The models will be save in the `PATH`
                        folder defined in the ./scripts/dashboards/covid_ch/config.py script.

    """

    def _most_recent_foph_dag_run(dt):
        """
        This internal method is capable of getting the `foph` dag runs.
        Uses a airflow datetime macro received by the Foph DAG itself and
        returns the DAG most recent execution date scheduled.
        @warning: will auto update every Scheduler pulse. 
        """
        foph_runs = DagRun.find(dag_id="foph")
        foph_runs.sort(key=lambda x: x.execution_date, reverse=True)
        return foph_runs[0].execution_date

    triggered_by_foph = ExternalTaskSensor(
        task_id="wait_for_foph",
        external_dag_id="foph",
        allowed_states=["success"],
        external_task_ids=["done"],
        execution_date_fn=_most_recent_foph_dag_run,
        check_existence=True,
        timeout=15,
    )

    start = EmptyOperator(
        task_id="start",
    )

    @task(task_id="train_new_hosp_models", retries=2)
    def train_new_hosp():

        target_curve_name = "hosp"
        predictors = ["foph_test_d", "foph_cases_d", "foph_hosp_d"]
        ini_date = "2020-05-01"

        train_all_cantons(
            target_curve_name,
            predictors,
            ini_date=ini_date,
            path=PATH,
        )

        logger.info("Train new hospitalization models.")

    @task(task_id="train_total_hosp_models", retries=2)
    def train_total_hosp():

        target_curve_name = "total_hosp"
        predictors = ["foph_test_d", "foph_cases_d", "foph_hosp_d", "foph_hospcapacity_d"]
        ini_date = "2020-05-01"

        train_all_cantons(
            target_curve_name,
            predictors,
            ini_date=ini_date,
            path=PATH,
        )

        logger.info("Train total hospitalization models.")

    @task(task_id="train_total_icu_models", retries=2)
    def train_total_icu():

        target_curve_name = "icu_patients"
        predictors = ["foph_test_d", "foph_cases_d", "foph_hosp_d", "foph_hospcapacity_d"]
        ini_date = "2020-05-01"

        train_all_cantons(
            target_curve_name,
            predictors,
            ini_date=ini_date,
            path=PATH,
        )

        logger.info("Train total ICU models.")

    end = EmptyOperator(
        task_id="done",
        trigger_rule="all_success",
    )

    """
    Task Dependencies
    -----------------
    This area defines the task dependencies. A task depends on
    another one if followed by a right bit shift (>>).
    """

    triggered_by_foph >> start
    start >> train_new_hosp() >> train_total_hosp() >> train_total_icu() >> end


dag = train_covidch()