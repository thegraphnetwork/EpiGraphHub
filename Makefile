SERVICES:=superset airflow
SERVICE:=superset
# options: dev, prod
ENV:=$(shell scripts/get-env-name.sh)
CONSOLE:=bash
CMD:=
ARGS:=
TIMEOUT:=90

# https://github.com/containers/podman-compose/issues/491#issuecomment-1289944841
CONTAINER_APP=docker-compose \
	--env-file=.env \
	--project-name egh-$(ENV) \
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
containers-start:
	set -ex
	$(CONTAINER_APP) up --remove-orphans -d ${SERVICES}

.PHONY:containers-start-services
containers-start-services: prepare-host
	set -e
	if [ "${ENV}" = "dev" ]; then \
		$(MAKE) containers-start SERVICES="postgres"
		$(MAKE) containers-wait SERVICE="postgres"; \
	fi
	$(MAKE) containers-start SERVICES="${SERVICES}"
	$(MAKE) containers-wait SERVICE="airflow"

.PHONY:containers-stop
containers-stop:
	set -ex
	$(CONTAINER_APP) stop ${ARGS} ${SERVICES}

.PHONY:containers-rm
containers-rm:
	set -ex
	$(CONTAINER_APP) rm ${ARGS} ${SERVICES}


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
	if [ "${ENV}" = "dev" ]; then \
		$(MAKE) containers-wait SERVICE="postgres"; \
	fi
	$(MAKE) containers-wait ENV=${ENV} SERVICE="minio"
	$(MAKE) containers-wait ENV=${ENV} SERVICE="redis"
	$(MAKE) containers-wait ENV=${ENV} SERVICE="flower"
	$(MAKE) containers-wait ENV=${ENV} SERVICE="superset"
	$(MAKE) containers-wait ENV=${ENV} SERVICE="airflow"

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
containers-exec:
	set -e
	$(CONTAINER_APP) exec ${ARGS} ${SERVICE} ${CMD}

.PHONY:containers-console
containers-console:
	set -e
	$(MAKE) containers-exec ARGS="${ARGS}" SERVICE=${SERVICE} CMD="${CONSOLE}"

.PHONY:containers-run-console
containers-run-console:
	set -e
	$(CONTAINER_APP) run --rm ${ARGS} ${SERVICE} ${CONSOLE}

.PHONY:containers-down
containers-down:
	$(CONTAINER_APP) down --volumes --remove-orphans


# https://github.com/containers/podman/issues/5114#issuecomment-779406347
.PHONY:containers-reset-storage
containers-reset-storage:
	rm -rf ~/.local/share/containers/


# aws

.ONESHELL:
.PHONY: dev-create-s3-credential
dev-create-s3-credential:
	set -e
	./scripts/dev/create-s3-credential.sh

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
