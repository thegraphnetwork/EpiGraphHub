FROM epigraphhub/superset-base

COPY --chown=epigraphhub:epigraphhub docker/celery/entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["tini", "--", "/opt/entrypoint.sh"]
