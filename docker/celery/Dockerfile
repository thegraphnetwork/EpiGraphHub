FROM epigraphhub/superset-base

COPY --chown=epigraphhub:epigraphhub docker/celery/entrypoint.sh /opt/entrypoint.sh

CMD ["celery", "--app=superset.tasks.celery_app:app worker", "--pool=prefork", "-O", "fair", "-c", "4"]
