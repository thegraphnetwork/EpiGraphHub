import logging
import re
import pendulum
import os
from datetime import timedelta
from urllib.request import urlopen
from airflow.decorators import dag, task
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator

AIRFLOW_HOME = os.getenv("AIRFLOW_HOME")

default_args = {
    "owner": "Airflow",  # This should be visible for the Admin only
    "depends_on_past": False,
    "start_date": pendulum.datetime(2022, 9, 26),
    "email": ["admin@epgraphhub.org"],
    "email_on_failure": True,
    "email_on_retry": False,
    "retries": 3,
    "retry_delay": timedelta(minutes=5),
}


@dag(
    schedule="@daily",
    default_args=default_args,
    catchup=False,
)
def web_status_test():
    """
    This DAG will send a request to every URL in `webservices.txt`, where
    each URL has its own task that will be marked as success if the URL
    request responds any 200 code.
    """

    exp = "^http[s]?:\/\/"  # Enable comments in .txt file
    services = []
    with open(f"{AIRFLOW_HOME}/dags/tests/webservices.txt", "r") as f:
        file = f.read()
        matches = re.findall(f"{exp}.*", file, re.MULTILINE)
        for match in matches:
            services.append(match)

    def url_status_check(url):
        # Return True if the status code is 2**
        resp = urlopen(url)
        code_str = str(resp.code)
        if code_str.startswith("2"):
            logging.info(f"{url} is active.")
        else:
            raise Exception(f"Could no reach {url}")

    start = EmptyOperator(
        task_id="test_EGH_URLs_status",
    )

    end = EmptyOperator(
        task_id="tests_passed",
        trigger_rule="all_success",
    )

    for service_url in services:
        service = re.sub(exp, "", service_url)
        service = service.replace("/", "-")

        check_url_status = PythonOperator(
            task_id=service,
            python_callable=url_status_check,
            op_kwargs={"url": service_url},
        )

        start >> check_url_status >> end


dag = web_status_test()
