# from https://github.com/postgis/docker-postgis/blob/969ef8a9e4a22e1556ca99cab4178f6e60c1483d/14-3.2/Dockerfile
# Reference: https://github.com/thegraphnetwork/epigraphhub_py/blob/main/docker/postgresql/Dockerfile
FROM postgres:15-bullseye

LABEL maintainer="PostGIS Project - https://postgis.net"

ENV POSTGIS_MAJOR 3
ENV PGDATA ${PGDATA}
ARG environment
ARG UID
ARG GID

RUN usermod -u ${UID} postgres \
    && groupmod -g ${GID} postgres \
    && echo "postgres:x:${UID}:${GID}:PostgreSQL,,,:/var/lib/postgresql:/bin/bash" >> /etc/passwd 

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-cache showpkg postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
    && apt-get install -y --no-install-recommends \
        build-essential ca-certificates \
        postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
        postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
        postgresql-$PG_MAJOR-plr \
        postgresql-plpython3-$PG_MAJOR \
        postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

COPY containers/postgresql/initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
COPY containers/postgresql/sql/${environment}/* /docker-entrypoint-initdb.d/
COPY containers/postgresql/update-postgis.sh /usr/local/bin

RUN chmod +x /docker-entrypoint-initdb.d/* \
    && mkdir -p /var/lib/postgresql/data/pgdata \
    && chown -R postgres:postgres /var/lib/postgresql/data/pgdata /var/run/postgresql

USER postgres

# Overrides default image config
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
