FROM apache/airflow:2.7.1

LABEL maintainer="Ivan Ogasawara <ivan.ogasawara@gmail.com>"
LABEL org.opencontainers.image.title="EpiGraphHub"
LABEL org.opencontainers.image.authors="EpiGraphHub Team"
LABEL org.opencontainers.image.source="https://github.com/thegraphnetwork/EpiGraphHub"
LABEL org.opencontainers.image.version="latest"
LABEL org.opencontainers.image.description="EpiGraphHub"
LABEL org.thegraphnetwork.epigraphhub.version="latest"

# it is the default, but using it here to have it explicitly
USER root

ENV DEBIAN_FRONTEND=noninteractive
ARG AIRFLOW_UID

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
    build-essential \
    zip \
    make \
    cron \
    curl \
    wget \
    sudo \
    tini \
    apt-transport-https \
    apt-utils \
    build-essential \
    ca-certificates \
    gnupg \
    dirmngr \
    vim \
    libssl-dev \
    liblzo2-dev \
    libpam0g-dev \
    zlib1g-dev \
    libffi-dev \
    libbz2-dev \
    libsqlite3-dev \
  && rm -rf /var/lib/apt/lists/* \
    /var/cache/apt/archives \
    /tmp/*

RUN usermod -u ${AIRFLOW_UID} -g 0 -d /home/airflow -s /bin/bash airflow \
 && echo "airflow ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/airflow \
 && chmod 0440 /etc/sudoers.d/airflow \
 && mkdir -p ${AIRFLOW_HOME}/scripts /opt/envs \
 && chown -R ${AIRFLOW_UID}:0 ${AIRFLOW_HOME} /opt/envs/

RUN curl https://www.python.org/ftp/python/3.10.8/Python-3.10.8.tgz -o /tmp/Python-3.10.8.tgz \
    && tar -zxvf /tmp/Python-3.10.8.tgz -C /tmp \
    && cd /tmp/Python-3.10.8 \
    && ./configure --prefix=/opt/py310 --enable-optimizations \
    && make install \
    && chown -R airflow /opt/py310 \
    && echo "alias python3.10=/opt/py310/bin/python3.10" >> /home/airflow/.bashrc \
    && rm -rf /tmp/Python-3.10*

RUN curl https://www.python.org/ftp/python/3.11.6/Python-3.11.6.tgz -o /tmp/Python-3.11.6.tgz \
    && tar -zxvf /tmp/Python-3.11.6.tgz -C /tmp \
    && cd /tmp/Python-3.11.6 \
    && ./configure --prefix=/opt/py311 --enable-optimizations \
    && make install \
    && chown -R airflow /opt/py311 \
    && echo "alias python3.11=/opt/py311/bin/python3.11" >> /home/airflow/.bashrc \
    && rm -rf /tmp/Python-3.11*
 
COPY --chown=airflow containers/airflow/config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg
COPY --chown=airflow containers/airflow/scripts/*.sh ${AIRFLOW_HOME}/scripts/
COPY --chown=airflow containers/airflow/scripts/entrypoint.sh /opt/entrypoint.sh
COPY --chown=airflow containers/airflow/envs/* /opt/envs/

USER airflow

ARG DB_URI
ENV DB_URI "${DB_URI}"

RUN /usr/local/bin/python -m virtualenv /opt/envs/py310 --python="/opt/py310/bin/python3.10" \
    && sed -i "s/include-system-site-packages = false/include-system-site-packages = true/" /opt/envs/py310/pyvenv.cfg \
    && source /opt/envs/py310/bin/activate \
    && pip install "cython<3.0.0" \
    && pip install --no-build-isolation "pyyaml<6.0" \
    && pip install -r /opt/envs/epigraphhub.txt \
    && epigraphhub-config --name "epigraphhub" --db-uri "${DB_URI}"

RUN /usr/local/bin/python -m virtualenv /opt/envs/py311 --python="/opt/py311/bin/python3.11" \
    && sed -i "s/include-system-site-packages = false/include-system-site-packages = true/" /opt/envs/py311/pyvenv.cfg \
    && source /opt/envs/py311/bin/activate \
    && pip install "cython<3.0.0" \
    && pip install --no-build-isolation "pyyaml<6.0" \
    && pip install \
        psycopg2-binary \
        -r /opt/envs/pysus.txt

WORKDIR ${AIRFLOW_HOME}

# ref: https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive
RUN sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

RUN sudo mkdir -p /opt/scripts /sources /opt/airflow \
  && sudo chown -R airflow /opt/scripts \
  && sudo chown -R airflow /sources \
  && sudo chown -R airflow /opt/airflow \
  && sudo touch /var/log/owid_fetch.log \
  && sudo touch /var/log/foph_fetch.log \
  && sudo touch /var/log/colombia_fetch.log \
  && sudo chown -R airflow /var/log/*

ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD /opt/scripts/startup.sh
