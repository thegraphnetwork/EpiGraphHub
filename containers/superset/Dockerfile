# ref: https://github.com/mamba-org/micromamba-docker/blob/main/Dockerfile

FROM condaforge/mambaforge:latest

LABEL maintainer="Ivan Ogasawara <ivan.ogasawara@gmail.com>"
LABEL org.opencontainers.image.title="EpiGraphHub"
LABEL org.opencontainers.image.authors="EpiGraphHub Team"
LABEL org.opencontainers.image.source="https://github.com/thegraphnetwork/EpiGraphHub"
LABEL org.opencontainers.image.version="latest"
LABEL org.opencontainers.image.description="EpiGraphHub"
LABEL org.thegraphnetwork.epigraphhub.version="latest"

# it is the default, but using it here to have it explicitly
USER root

SHELL ["/bin/bash", "-c"]
# Use bash in Dockerfile RUN commands and make sure bashrc is sourced when
# executing commands with /bin/bash -c
# Needed to have the micromamba activate command configured etc.

ENV ENV_NAME=epigraphhub
ENV DEBIAN_FRONTEND=noninteractive
ARG UID=1000
ARG GID=1000

RUN apt-get update -y \
  && apt-get install -y \
    build-essential \
    zip \
    make \
    cron \
    curl \
    wget \
    sudo \
    tini \
  && rm -rf /var/lib/apt/lists/* \
    /var/cache/apt/archives \
    /tmp/* \
  && addgroup --gid ${GID} epigraphhub \
  && useradd --uid ${UID} --gid ${GID} -ms /bin/bash epigraphhub \
  && mkdir -p /opt/EpiGraphHub \
  && chmod -R a+rwx /opt/conda /opt/EpiGraphHub \
  && export ENV_NAME="$ENV_NAME" \
  && echo "epigraphhub ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/epigraphhub \
  && chmod 0440 /etc/sudoers.d/epigraphhub \
  && mkdir -p /opt/superset \
  && chown epigraphhub:epigraphhub /opt/superset \
  && chmod a+rw /var/log/

USER epigraphhub

WORKDIR /opt/EpiGraphHub

COPY --chown=epigraphhub:epigraphhub conda/ /tmp/conda

ENV PATH /opt/conda/envs/$ENV_NAME/bin:$PATH
ENV PYTHONPATH='/opt/superset:/opt/EpiGraphHub'
ENV ANSIBLE_CONFIG='/opt/EpiGraphHub/playbooks/ansible.cfg'

RUN mamba env create -n $ENV_NAME --file /tmp/conda/superset.yaml \
  && conda clean --all \
  && find /opt/conda/ -type f,l -name '*.a' -delete \
  && find /opt/conda/ -type f,l -name '*.pyc' -delete \
  && find /opt/conda/ -type f,l -name '*.js.map' -delete \
  && rm -rf /opt/conda/pkgs /tmp/*

# note: keeping it to the end of the recipes helps to avoid rebuilding the
#       image after every change.
# COPY --chown=epigraphhub:epigraphhub . /opt/EpiGraphHub

COPY --chown=epigraphhub:epigraphhub containers/superset/superset.sh /opt/superset.sh
# note: these files can be overwriten by docker compose volumes in order to
#       use the last version without building the image again.
COPY --chown=epigraphhub:epigraphhub containers/superset/ /opt/superset
COPY --chown=epigraphhub:epigraphhub containers/superset/entrypoint.sh /opt/entrypoint.sh

RUN chmod +x /opt/entrypoint.sh \
  && echo "source /opt/entrypoint.sh" > ~/.bashrc \
  && sudo mkdir -p /opt/data/superset/ \
  && sudo chown -R epigraphhub:epigraphhub /opt/data \
  && sudo chown -R epigraphhub:epigraphhub /var/log/*


ENTRYPOINT ["tini", "--", "/opt/entrypoint.sh"]
CMD ["/opt/superset.sh"]
