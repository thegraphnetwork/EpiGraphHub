#!/usr/bin/env bash

set -e

# initdb
echo "=========== init-db ==========="
. /opt/scripts/init-db.sh

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

# just to keep the prompt blocked
mkdir -p /tmp/empty
cd /tmp/empty

# give privileges to log files
chown -R $USER:$USER /var/log/*

echo "========= DONE ========="
python -m http.server
