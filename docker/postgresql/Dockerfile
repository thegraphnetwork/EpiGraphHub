# from https://github.com/postgis/docker-postgis/blob/969ef8a9e4a22e1556ca99cab4178f6e60c1483d/14-3.2/Dockerfile
# Reference: https://github.com/thegraphnetwork/epigraphhub_py/blob/main/docker/postgresql/Dockerfile
FROM postgres:14-bullseye

LABEL maintainer="PostGIS Project - https://postgis.net"

ENV POSTGIS_MAJOR 3

RUN apt-get update \
      && apt-cache showpkg postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./docker/postgresql/initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./docker/postgresql/update-postgis.sh /usr/local/bin


ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update --yes \
  && apt-get -qq install --yes --no-install-recommends \
  build-essential ca-certificates \
  postgresql-$PG_MAJOR-plr \
  postgresql-plpython3-$PG_MAJOR \
  postgresql-contrib \
  && rm -rf /var/lib/apt/lists/*
