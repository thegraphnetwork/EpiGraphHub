FROM condaforge/mambaforge:latest

# it is the default, but using it here to have it explicitly
USER root

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y \
    && apt-get install -y \
      build-essential \
      openssh-server \
      gnupg2 \
      zip \
      make \
      cron \
      curl \
      wget \
      sudo \
      libssl-dev \
      libffi-dev \ 
      libsasl2-dev \ 
      libldap2-dev \
    && rm -rf /var/lib/apt/lists/*

# ref: https://github.com/mamba-org/micromamba-docker/blob/main/Dockerfile

# Use bash in Dockerfile RUN commands and make sure bashrc is sourced when
# executing commands with /bin/bash -c
# Needed to have the micromamba activate command configured etc.
SHELL ["/bin/bash", "-c"]

ENV ENV_NAME=epigraphhub

ARG UID=1000  # default value 1000
ARG GID=1000  # default value 1000

RUN addgroup --gid ${GID} epigraphhub \
  && useradd --uid ${UID} --gid ${GID} -ms /bin/bash epigraphhub \
  && mkdir -p /opt/conda /opt/EpiGraphHub \
  && chmod -R a+rwx /opt/conda /opt/EpiGraphHub \
  && export ENV_NAME="$ENV_NAME" \
  && echo "epigraphhub ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/epigraphhub \
  && chmod 0440 /etc/sudoers.d/epigraphhub

RUN chmod a+rw /var/log/

USER epigraphhub

WORKDIR /opt/EpiGraphHub

# ssh keys for ansible deployment
RUN mkdir -p ${HOME}/.ssh

COPY --chown=epigraphhub:epigraphhub conda/prod.yaml /tmp/envs/epigraphhub.yml

ENV PATH /opt/conda/envs/$ENV_NAME/bin:$PATH

RUN mamba env create -n $ENV_NAME \
    --file /tmp/envs/epigraphhub.yml \
  && conda clean --all \
  && find /opt/conda/ -type f,l -name '*.a' -delete \
  && find /opt/conda/ -type f,l -name '*.pyc' -delete \
  && find /opt/conda/ -type f,l -name '*.js.map' -delete \
  && rm -rf /opt/conda/pkgs

EXPOSE 8000
ENV PYTHONPATH='.'
ENV ANSIBLE_CONFIG='/opt/EpiGraphHub/playbooks/ansible.cfg'

# note: keeping it to the end of the recipes helps to avoid rebuilding the
#       image after every change.
# COPY --chown=epigraphhub:epigraphhub . /opt/EpiGraphHub

COPY --chown=epigraphhub:epigraphhub docker/entrypoint.sh /opt/entrypoint.sh
COPY --chown=epigraphhub:epigraphhub docker/superset.sh /opt/superset.sh

RUN chmod +x /opt/entrypoint.sh /opt/superset.sh

RUN echo "source /opt/entrypoint.sh" > ~/.bashrc 

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/opt/superset.sh"]
