#!/usr/bin/env bash

set -e

airflow users create \
  --username ${_AIRFLOW_WWW_USER_USERNAME} \
  --password ${_AIRFLOW_WWW_USER_PASSWORD} \
  --email ${_AIRFLOW_WWW_USER_EMAIL} \
  --firstname ${_AIRFLOW_WWW_USER_FIRST_NAME} \
  --lastname ${_AIRFLOW_WWW_USER_LAST_NAME} \
  --role Admin
