#!/usr/bin/env bash

set -x

export FLASK_APP=superset

# Initialize the database
superset db upgrade

set -e

if [[ $ENV = "dev" ]]; then
  echo "Running in development mode ..."
  superset fab create-admin \
    --username admin \
    --firstname Superset \
    --lastname Admin \
    --email admin@superset.com \
    --password admin
elif [[ $ENV = "prod" ]]; then
  echo "Running in production mode ..."
else
  echo "No environment provided (dev or prod)."
  exit 1
fi

# Create default roles and permissions
superset init

set +ex

. /opt/superset/celery.sh &
. /opt/superset/celery-beat.sh &

superset run -p 8088 --host=0.0.0.0 --with-threads --reload
