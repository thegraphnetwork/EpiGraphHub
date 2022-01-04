#!/usr/bin/env bash

# Initialize the database
superset db upgrade

# Create an admin user (you will be prompted to set a username, first and last name before setting a password)
export FLASK_APP=superset
superset fab create-admin \
    --username admin \
    --firstname Superset \
    --lastname Admin \
    --email admin@superset.com \
    --password admin

# Create default roles and permissions
superset init

# To start a development web server on port 8088, use -p to bind to another port
superset run -p 8088 --host=0.0.0.0 --with-threads --reload
