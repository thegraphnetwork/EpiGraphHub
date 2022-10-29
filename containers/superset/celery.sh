#!/usr/bin/env bash

celery \
  --app=superset.tasks.celery_app:app \
  worker -Ofair -l INFO
