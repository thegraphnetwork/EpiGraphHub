"""
@author 
@date Last change on 2022-10-24

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

from airflow.models import DagRun
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.sensors.external_task import ExternalTaskSensor

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

    @task
    def say_hi():
        print("hi!")

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

    triggered_by_foph >> start >> say_hi() >> end


dag = update_covidch()
