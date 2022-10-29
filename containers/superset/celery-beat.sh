#!/usr/bin/env bash

celery \
  --app=superset.tasks.celery_app:app \
  beat --pidfile /tmp/celerybeat.pid \
  -l INFO -s ${SUPERSET_HOME}/celerybeat-schedule
