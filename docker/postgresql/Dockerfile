FROM postgis/postgis:14-3.2

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y \
    && apt-get install -y \
      postgresql-14-plr \
      postgresql-14-postgis-3-scripts \
      postgresql-plpython3-14 \
      postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*
