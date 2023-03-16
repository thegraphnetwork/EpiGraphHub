_AIRFLOW_DB_UPGRADE=${_AIRFLOW_DB_UPGRADE:-True}
_AIRFLOW_WWW_USER_CREATE=${_AIRFLOW_WWW_USER_CREATE:-True}
_AIRFLOW_WWW_USER_USERNAME=${_AIRFLOW_WWW_USER_USERNAME}
_AIRFLOW_WWW_USER_PASSWORD=${_AIRFLOW_WWW_USER_PASSWORD}
_AIRFLOW_WWW_USER_EMAIL=${_AIRFLOW_WWW_USER_EMAIL}
_AIRFLOW_WWW_USER_FIRST_NAME=${_AIRFLOW_WWW_USER_FIRST_NAME}
_AIRFLOW_WWW_USER_LAST_NAME=${_AIRFLOW_WWW_USER_LAST_NAME}
_PIP_ADDITIONAL_REQUIREMENTS=${_PIP_ADDITIONAL_REQUIREMENTS}
AIRFLOW__API__AUTH_BACKENDS=${AIRFLOW__API__AUTH_BACKENDS:-"airflow.api.auth.backend.basic_auth"}
AIRFLOW__CORE__DAGS_ARE_PAUSED_AT_CREATION=${AIRFLOW__CORE__DAGS_ARE_PAUSED_AT_CREATION}
AIRFLOW__CORE__FERNET_KEY=${AIRFLOW__CORE__FERNET_KEY}
AIRFLOW__DATABASE__SQL_ALCHEMY_CONN=${AIRFLOW__DATABASE__SQL_ALCHEMY_CONN}
AIRFLOW__WEBSERVER__SECRET_KEY=${AIRFLOW__WEBSERVER__SECRET_KEY}
AIRFLOW__SMTP__SMTP_HOST=${AIRFLOW__SMTP__SMTP_HOST:-"smtp.sendgrid.net"}
AIRFLOW__SMTP__SMTP_STARTTLS=${AIRFLOW__SMTP__SMTP_STARTTLS:-False}
AIRFLOW__SMTP__SMTP_SSL=${AIRFLOW__SMTP__SMTP_SSL:-False}
AIRFLOW__SMTP__SMTP_USER=${AIRFLOW__SMTP__SMTP_USER}
AIRFLOW__SMTP__SMTP_PASSWORD=${AIRFLOW__SMTP__SMTP_PASSWORD}
AIRFLOW__SMTP__SMTP_PORT=${AIRFLOW__SMTP__SMTP_PORT:-587}
AIRFLOW__SMTP__SMTP_MAIL_FROM=${AIRFLOW__SMTP__SMTP_MAIL_FROM}
AIRFLOW_UID=${AIRFLOW_UID}
AIRFLOW_PORT=${AIRFLOW_PORT}
AIRFLOW_FILES_PATH_DIR_HOST=${AIRFLOW_FILES_PATH_DIR_HOST}
ANSIBLE_VAULT_KEY=${ANSIBLE_VAULT_KEY}
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
ENV=${ENV}
FLOWER_PORT=${FLOWER_PORT}
FLOWER_PASSWORD=${FLOWER_PASSWORD}
MINIO_PORT_1=${MINIO_PORT_1}
MINIO_PORT_2=${MINIO_PORT_2}
MINIO_ROOT_USER=${MINIO_ROOT_USER}
MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
MAPBOX_API_KEY=${MAPBOX_API_KEY}
POSTGRES_HOST=${POSTGRES_HOST}
POSTGRES_PORT=${POSTGRES_PORT}
POSTGRES_USER=${POSTGRES_USER}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
POSTGRES_DB=${POSTGRES_DB}
POSTGRES_EPIGRAPH_USER=${POSTGRES_EPIGRAPH_USER}
POSTGRES_EPIGRAPH_PASSWORD=${POSTGRES_EPIGRAPH_PASSWORD}
POSTGRES_EPIGRAPH_DB=${POSTGRES_EPIGRAPH_DB}
POSTGRES_EPIGRAPH_DB_PRIVATE=${POSTGRES_DB_EPIGRAPH_PRIVATE}
POSTGRES_EPIGRAPH_DB_SANDBOX=${POSTGRES_DB_EPIGRAPH_SANDBOX}
RECAPTCHA_PUBLIC_KEY=${RECAPTCHA_PUBLIC_KEY}
RECAPTCHA_PRIVATE_KEY=${RECAPTCHA_PRIVATE_KEY}
REDIS_HOST=${REDIS_HOST}
REDIS_PORT=${REDIS_PORT}
REDIS_PASSWORD=${REDIS_PASSWORD}
SUPERSET_DB_PATH_HOST=${SUPERSET_DB_PATH_HOST}
SUPERSET_DB_PATH_DIR_HOST=${SUPERSET_DB_PATH_DIR_HOST}
SUPERSET_SECRET_KEY=${SUPERSET_SECRET_KEY}
SUPERSET_PORT=${SUPERSET_PORT}
SUPERSET_DEFAULT_NEW_ROLES=${SUPERSET_DEFAULT_NEW_ROLES}
SUPERSET_HOME=${SUPERSET_HOME:-/opt/data/superset}
SUPERSET_MAIL_SERVER=${SUPERSET_MAIL_SERVER}
SUPERSET_MAIL_USE_TLS=${SUPERSET_MAIL_USE_TLS:-True}
SUPERSET_MAIL_PORT=${SUPERSET_MAIL_PORT:-587}
SUPERSET_MAIL_USERNAME=${SUPERSET_MAIL_USERNAME}
SUPERSET_MAIL_PASSWORD=${SUPERSET_MAIL_PASSWORD}
SUPERSET_MAIL_DEFAULT_SENDER=${SUPERSET_MAIL_DEFAULT_SENDER}
HOST_UID=${HOST_UID}
HOST_GID=${HOST_GID}
