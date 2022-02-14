SERVICES:=epigraphhub
SERVICE:=epigraphhub
# options: dev, prod
ENV:=dev

ifeq ($(ENV), dev)
DOCKER=docker-compose --file docker/compose-base.yaml --file docker/compose-dev.yaml
endif

ifeq ($(ENV), prod)
DOCKER=docker-compose --file docker/compose-base.yaml --file docker/compose-prod.yaml
endif


# DOCKER

.PHONY:docker-build
docker-build:
	$(DOCKER) build
	$(DOCKER) pull


.PHONY:docker-up
docker-up:
	$(DOCKER) up -d ${SERVICES}


.PHONY:docker-dev-prepare-db
docker-dev-prepare-db:
	# used for development
	$(DOCKER) exec -T epigraphhub bash /opt/EpiGraphHub/docker/prepare-db.sh


.PHONY:docker-run-cron
docker-run-cron:
	$(DOCKER) exec -T ${SERVICE} bash /opt/EpiGraphHub/Data_Collection/CRON_scripts/owid.sh
	$(DOCKER) exec -T ${SERVICE} bash /opt/EpiGraphHub/Data_Collection/CRON_scripts/foph.sh
	# $(DOCKER) exec -T ${SERVICE} bash /opt/EpiGraphHub/Data_Collection/CRON_scripts/forecast.sh


.PHONY:docker-bash
docker-bash:
	$(DOCKER) exec ${SERVICE} bash
