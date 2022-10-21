SERVICES:=superset airflow
SERVICE:=superset
# options: dev, prod
ENV:=$(shell scripts/get-env-name.sh)
CONSOLE:=bash
CRON:=
ARGS:=
TIMEOUT:=90


CONTAINER_APP=podman-compose \
	--env-file=.env \
	--project-name eph-$(ENV) \
	--file containers/compose-base.yaml \
	--file containers/compose-$(ENV).yaml

# HOST

.PHONY: prepare-host
prepare-host:
	bash scripts/prepare-host.sh

# CONTAINER_APP

.ONESHELL:
.PHONY:containers-pull
containers-pull:
	set -e
	$(CONTAINER_APP) pull ${SERVICES}

.ONESHELL:
.PHONY:containers-build
containers-build: containers-pull
	set -e
	$(CONTAINER_APP) build ${SERVICES}

.PHONY:containers-start
containers-start: prepare-host
	set -e
	if [ "${ENV}" = "dev" ]; then \
		$(CONTAINER_APP) up -d postgres; \
		./containers/healthcheck.sh postgres; \
	fi
	$(CONTAINER_APP) up --remove-orphans -d ${SERVICES}
	$(MAKE) containers-wait SERVICE=airflow

.PHONY:containers-stop
containers-stop:
	$(CONTAINER_APP) stop ${SERVICES}

.PHONY:containers-restart
containers-restart: containers-stop containers-start

.PHONY:containers-logs
containers-logs:
	$(CONTAINER_APP) logs ${ARGS} ${SERVICES}

.PHONY:containers-logs-follow
containers-logs-follow:
	$(CONTAINER_APP) logs --follow ${ARGS} ${SERVICES}

.PHONY: containers-wait
containers-wait:
	ENV=${ENV} timeout ${TIMEOUT} ./containers/healthcheck.sh ${SERVICE}

.PHONY: containers-wait-all
containers-wait-all:
	# $(MAKE) containers-wait ENV=${ENV} SERVICE="postgres"
	$(MAKE) containers-wait ENV=${ENV} SERVICE="redis"
	$(MAKE) containers-wait ENV=${ENV} SERVICE="flower"
	$(MAKE) containers-wait ENV=${ENV} SERVICE="superset"
	$(MAKE) containers-wait ENV=${ENV} SERVICE="airflow"

.PHONY:containers-dev-prepare-db
containers-dev-prepare-db:
	# used for development
	$(CONTAINER_APP) exec -T superset \
		bash /opt/EpiGraphHub/containers/postgresql/scripts/dev/prepare-db.sh

.PHONY:containers-get-ip
containers-get-ip:
	@echo -n "${SERVICE}: "
	@docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
		eph-${ENV}_${SERVICE}_1

.PHONY:containers-get-ips
containers-get-ips:
	@$(MAKE) containers-get-ip ENV=${ENV} SERVICE="superset"
	@$(MAKE) containers-get-ip ENV=${ENV} SERVICE="flower"
	@$(MAKE) containers-get-ip ENV=${ENV} SERVICE="postgres"
	@$(MAKE) containers-get-ip ENV=${ENV} SERVICE="airflow"

.PHONY:containers-exec
containers-console:
	$(CONTAINER_APP) exec -it ${SERVICE} ${CONSOLE}

.PHONY:containers-run-console
containers-run-console:
	$(CONTAINER_APP) run --rm ${SERVICE} ${CONSOLE}

.PHONY:containers-down
containers-down:
	$(CONTAINER_APP) down --volumes --remove-orphans

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
