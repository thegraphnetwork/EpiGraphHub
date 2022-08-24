SERVICES:=superset airflow
SERVICE:=superset
# options: dev, prod
ENV:=$(shell scripts/get-env-name.sh)
CONSOLE:=bash
CRON:=
ARGS:=
TIMEOUT:=90


DOCKER=docker-compose \
	--env-file .env \
	--project-name eph-$(ENV) \
	--file docker/compose-base.yaml \
	--file docker/compose-$(ENV).yaml

# HOST

.PHONY: prepare-host
prepare-host:
	bash scripts/prepare-host.sh

# DOCKER

.ONESHELL:
.PHONY:docker-pull
docker-pull:
	set -e
	$(DOCKER) pull ${SERVICES}

.ONESHELL:
.PHONY:docker-build
docker-build:
	set -e
	$(DOCKER) build ${SERVICES}

.ONESHELL:
.PHONY:docker-build-services
docker-build-services: docker-pull
	set -e
	$(MAKE) docker-build SERVICES="superset"
	$(DOCKER) build ${SERVICES}

.PHONY:docker-start
docker-start: prepare-host
	set -e
	if [ "${ENV}" = "dev" ]; then \
		$(DOCKER) up -d postgres; \
		./docker/healthcheck.sh postgres; \
	fi
	$(DOCKER) up --remove-orphans -d ${SERVICES}
	$(MAKE) docker-wait SERVICE=airflow

.PHONY:docker-stop
docker-stop:
	$(DOCKER) stop ${SERVICES}

.PHONY:docker-restart
docker-restart: docker-stop docker-start

.PHONY:docker-logs
docker-logs:
	$(DOCKER) logs ${ARGS} ${SERVICES}

.PHONY:docker-logs-follow
docker-logs-follow:
	$(DOCKER) logs --follow ${ARGS} ${SERVICES}

.PHONY: docker-wait
docker-wait:
	ENV=${ENV} timeout ${TIMEOUT} ./docker/healthcheck.sh ${SERVICE}

.PHONY: docker-wait-all
docker-wait-all:
	# $(MAKE) docker-wait ENV=${ENV} SERVICE="postgres"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="redis"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="flower"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="superset"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="airflow"

.PHONY:docker-dev-prepare-db
docker-dev-prepare-db:
	# used for development
	$(DOCKER) exec -T superset \
		bash /opt/EpiGraphHub/docker/postgresql/scripts/dev/prepare-db.sh

.PHONY:docker-run-cron
docker-run-cron:
	$(MAKE) docker-cron ENV=${ENV} CRON=owid.sh
	$(MAKE) docker-cron ENV=${ENV} CRON=foph.sh
	# $(MAKE) docker-cron ENV=${ENV} CRON=forecast.sh

.PHONY:docker-cron
docker-cron:
	$(DOCKER) exec -T superset bash \
		/opt/EpiGraphHub/Data_Collection/CRON_scripts/${CRON}

.PHONY:docker-get-ip
docker-get-ip:
	@echo -n "${SERVICE}: "
	@docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
		eph-${ENV}_${SERVICE}_1

.PHONY:docker-get-ips
docker-get-ips:
	@$(MAKE) docker-get-ip ENV=${ENV} SERVICE="superset"
	@$(MAKE) docker-get-ip ENV=${ENV} SERVICE="flower"

.PHONY:docker-console
docker-console:
	$(DOCKER) exec ${SERVICE} ${CONSOLE}

.PHONY:docker-run-console
docker-run-console:
	$(DOCKER) run --rm ${SERVICE} ${CONSOLE}


.PHONY:docker-down
docker-down:
	$(DOCKER) down --volumes --remove-orphans


# conda

.ONESHELL:
.PHONY: conda-lock
conda-lock:
	cd conda
	rm -f conda-*.lock
	conda-lock --conda `which mamba` \
		-f prod.yaml  \
		-p osx-64 \
		-p linux-64 \
		--kind explicit
