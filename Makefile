SERVICES:=epigraphhub-superset
SERVICE:=epigraphhub-superset
# options: dev, prod
ENV:=dev
CONSOLE:=bash
CRON:=

DOCKER=docker-compose \
	--env-file .env \
	--project-name eph-$(ENV) \
	--file docker/compose-base.yaml \
	--file docker/compose-$(ENV).yaml

# DOCKER

.PHONY:docker-build
docker-build:
	$(DOCKER) build epigraphhub-base
	$(DOCKER) build ${SERVICES}
	$(DOCKER) pull ${SERVICES}


.PHONY:docker-start
docker-start:
	$(DOCKER) up --remove-orphans -d ${SERVICES}


.PHONY:docker-stop
docker-stop:
	$(DOCKER) stop ${SERVICES}


.PHONY:docker-restart
docker-restart: docker-stop docker-start
	echo "[II] Docker services restarted!"

.PHONY:docker-logs-follow
docker-logs-follow:
	$(DOCKER) logs --follow --tail 300 ${SERVICES}

.PHONY:docker-logs
docker-logs:
	$(DOCKER) logs --tail 300 ${SERVICES}

.PHONY: docker-wait
docker-wait:
	ENV=${ENV} timeout 90 ./docker/healthcheck.sh ${SERVICE}

.PHONY: docker-wait-all
docker-wait-all:
	$(MAKE) docker-wait ENV=${ENV} SERVICE="epigraphhub-db"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="epigraphhub-db"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="epigraphhub-redis"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="epigraphhub-celery"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="epigraphhub-celery-beat"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="epigraphhub-flower"
	$(MAKE) docker-wait ENV=${ENV} SERVICE="epigraphhub-superset"

.PHONY:docker-dev-prepare-db
docker-dev-prepare-db:
	# used for development
	$(DOCKER) exec -T epigraphhub-superset \
		bash /opt/EpiGraphHub/docker/postgresql/prepare-db.sh


.PHONY:docker-run-cron
docker-run-cron:
	$(MAKE) docker-cron ENV=${ENV} CRON=owid.sh
	$(MAKE) docker-cron ENV=${ENV} CRON=foph.sh
	# $(MAKE) docker-cron ENV=${ENV} CRON=forecast.sh


.PHONY:docker-cron
docker-cron:
	$(DOCKER) exec -T epigraphhub-superset bash \
		/opt/EpiGraphHub/Data_Collection/CRON_scripts/${CRON}


.PHONY:docker-get-ip
docker-get-ip:
	@echo -n "${SERVICE}: "
	@docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
		eph-${ENV}_epigraphhub-${SERVICE}_1

.PHONY:docker-get-ips
docker-get-ips:
	@$(MAKE) docker-get-ip ENV=${ENV} SERVICE="superset"
	@$(MAKE) docker-get-ip ENV=${ENV} SERVICE="celery"
	@$(MAKE) docker-get-ip ENV=${ENV} SERVICE="celery-beat"
	@$(MAKE) docker-get-ip ENV=${ENV} SERVICE="flower"


.PHONY:docker-console
docker-console:
	$(DOCKER) exec ${SERVICE} ${CONSOLE}


.PHONY:docker-run-bash
docker-run-bash:
	$(DOCKER) run --rm ${SERVICE} bash


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
