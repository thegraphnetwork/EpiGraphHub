#!/usr/bin/env bash

set -e

# initdb
echo "=========== init-db ==========="
airflow db init

# create admin user
echo "=========== init-db ==========="
. /opt/scripts/create-admin.sh

# start airflow
echo "========= airflow webserver ========="
airflow webserver &
sleep 10

# start scheduler
echo "========= airflow scheduler ========="
airflow scheduler &
sleep 10

airflow dags reserialize
sleep 5

# just to keep the prompt blocked
mkdir -p /tmp/empty
cd /tmp/empty

echo "========= DONE ========="
python -m http.server
