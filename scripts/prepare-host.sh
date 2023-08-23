#!/usr/bin/env bash

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && cd .. && pwd )"
export $(echo $(cat ${PROJECT_PATH}/.env | sed 's/#.*//g'| xargs -0) | envsubst)

set -ex

# airflow
mkdir -p ${AIRFLOW_FILES_PATH_DIR_HOST}
mkdir -p ${AIRFLOW_FILES_PATH_DIR_HOST}/logs
mkdir -p ${AIRFLOW_FILES_PATH_DIR_HOST}/logs/scheduler
mkdir -p ${AIRFLOW_FILES_PATH_DIR_HOST}/dags
mkdir -p ${AIRFLOW_FILES_PATH_DIR_HOST}/plugins
