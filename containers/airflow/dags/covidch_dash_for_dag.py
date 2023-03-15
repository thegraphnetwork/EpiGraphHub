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
from scripts.dashboards.covid_ch import forecast_all_cantons, save_to_database
from epigraphhub.connection import get_engine
from epigraphhub.settings import env 

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
    schedule_interval="@weekly",
    default_args=default_args,
    catchup=False,
)
def update_covidch():
    """
    This method represents the DAG itself using the @dag decorator. The method
    has to be instantiated so the Scheduler can recognize as a DAG. Update_covidch
    will be responsible to upload the forecast of the graph of new hospitalizations, total
    hospitalizations and total icu hospitalizations shown in the dashboard: http://epigraphhub.org/covidch/.
    This method must run after the FOPH DAG. This DAG should apply the models saved and send the tables with the results to the database. 

    Methods
    -------

    up_for_new_hosp()   :Update the forecast of new hospitalizations and 
                        save the results in the ngboost_forecast_hosp_d_results. 

    up_for_total_hosp() :Update the forecast of total hospitalizations and 
                        save the results in the ngboost_forecast_total_hosp_d_results. 

    up_for_total_icu()  :Update the forecast of total icu and 
                        save the results in the ngboost_forecast_total_icu_d_results. 

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

    @task(task_id="update_for_new_hosp", retries=2)
    def up_for_new_hosp():
        
        engine = get_engine(env.db.default_credential)

        df_for_hosp = forecast_all_cantons(
            "hosp",
            ["foph_test_d", "foph_cases_d", "foph_hosp_d"],
            vaccine=True,
            smooth=True,
            path=PATH,
        )

        save_to_database(df_for_hosp, "ngboost_forecast_hosp_d_results", engine=engine)

        logger.info("Table ngboost_forecast_hosp_d_results updated.")
        
    @task(task_id="update_for_total_hosp", retries=2)
    def up_for_total_hosp():
        
        engine = get_engine(env.db.default_credential)

        df_for_total_hosp = forecast_all_cantons(
            "total_hosp",
            ["foph_test_d", "foph_cases_d", "foph_hosp_d", "foph_hospcapacity_d"],
            vaccine=True,
            smooth=True,
            path=PATH,
        )

        save_to_database(
            df_for_total_hosp, "ngboost_forecast_total_hosp_d_results", engine=engine
        )

        logger.info("Table ngboost_forecast_total_hosp_d_results updated.")

    @task(task_id="update_for_new_hosp", retries=2)
    def up_for_total_icu():
        
        engine = get_engine(env.db.default_credential)

        df_for_icu = forecast_all_cantons(
            "icu_patients",
            ["foph_test_d", "foph_cases_d", "foph_hosp_d", "foph_hospcapacity_d"],
            vaccine=True,
            smooth=True,
            path=PATH,
        )

        save_to_database(df_for_icu, "ngboost_forecast_total_icu_d_results", engine=engine)

        logger.info("Table ngboost_forecast_icu_d_results updated.")


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
    start >> up_for_new_hosp() >> up_for_total_hosp() >> up_for_total_icu() >> end


dag = update_covidch()