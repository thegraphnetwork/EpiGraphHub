#!/usr/bin/env bash

set -ex

# Initialize the database
superset db upgrade

if [[ $ENV = "dev" ]]; then
  echo "Running in development mode ..."

  export FLASK_APP=superset
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

# To start a development web server on port 8088, use -p to bind to another port
superset run -p ${SUPERSET_PORT:-8088} --host=0.0.0.0 --with-threads --reload
