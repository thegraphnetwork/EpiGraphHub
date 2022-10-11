import os
import pytest
from airflow.models import DagBag


def test_no_import_errors():
    dag_bag = DagBag(include_examples=False)
    assert len(dag_bag.import_errors) == 0, "No import failures."


def test_each_dag_existence_in_default_airflow_location():
    dags = [
        # Production:
        "owid",
        "foph",
        "colombia",
        # Development:
        "web_status_test",
    ]
    airflow_path = os.getenv("AIRFLOW_HOME")
    dag_bag = DagBag(include_examples=False, dag_folder=f"{airflow_path}/dags")
    print(dag_bag.dag_ids)
    for dag in dags:
        assert dag in dag_bag.dag_ids, f"{dag} DAG found."
