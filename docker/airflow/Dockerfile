FROM epigraphhub/superset:latest

ENV AIRFLOW_HOME=/opt/airflow
ENV ENV_NAME=epigraphhub
ENV DEBIAN_FRONTEND=noninteractive

# ref: https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive
RUN sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# ref: https://hub.docker.com/r/apache/airflow/dockerfile
RUN sudo apt-get update -y \
  && sudo apt-get install -y --no-install-recommends \
    apt-transport-https \
    apt-utils \
    build-essential \
    ca-certificates \
    gnupg \
    dirmngr \
    freetds-bin \
    freetds-dev \
    gosu \
    ldap-utils \
    libffi-dev \
    libpq-dev \
    libsasl2-2 \
    libsasl2-dev \
    libsasl2-modules \
    libssl-dev \
    locales  \
    lsb-release \
    nodejs \
    openssh-client \
    postgresql-client \
    sasl2-bin \
    software-properties-common \
    sqlite3 \
    sudo \
    unixodbc \
    unixodbc-dev \
    yarn \
  && sudo rm -rf /var/lib/apt/lists/* \
    /var/cache/apt/archives \
    /tmp/*

COPY ./conda/airflow.yaml /tmp/airflow.yaml
COPY ./conda/pip.txt /tmp/pip.txt
RUN mamba env create -n ${ENV_NAME} --file /tmp/airflow.yaml --force

RUN sudo mkdir -p /opt/scripts /sources /opt/airflow \
  && sudo chown -R epigraphhub:epigraphhub /opt/scripts \
  && sudo chown -R epigraphhub:epigraphhub /sources \
  && sudo chown -R epigraphhub:epigraphhub /opt/airflow \
  && sudo chown -R epigraphhub:epigraphhub /var/log

COPY --chown=epigraphhub ./docker/airflow/airflow.cfg /opt/airflow/airflow.cfg
COPY --chown=epigraphhub ./docker/airflow/scripts/*.sh /opt/scripts/
COPY --chown=epigraphhub ./docker/airflow/scripts/entrypoint.sh /opt/entrypoint.sh
COPY --chown=epigraphhub ./docker/airflow/scripts/webserver_config.py /opt/airflow/webserver_config.py

ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD /opt/scripts/startup.sh
