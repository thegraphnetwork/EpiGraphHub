FROM apache/airflow:slim-latest-python3.10

ENV AIRFLOW_HOME=/opt/airflow

RUN pip install --user psycopg2-binary

COPY ./airflow.cfg /opt/airflow/airflow.cfg
COPY ./scripts/* /tmp/scripts/

# RUN chown -R airflow:airflow /usr/local/airflow
