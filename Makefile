DOCKER=docker-compose --file docker/docker-compose.yaml
SERVICES:=dev-epigraphhub
SERVICE:=dev-epigraphhub

# docker dev
.PHONY:docker-dev-build
docker-dev-build:
	$(DOCKER) build
	$(DOCKER) pull dev-epigraphhub-db

.PHONY:docker-dev-build-force
docker-dev-build-force:
	$(DOCKER) build --force ${SERVICES}
	$(DOCKER) pull dev-epigraphhub-db

.PHONY:docker-up
docker-up:
	$(DOCKER) up -d ${SERVICES}

.PHONY:docker-dev-prepare-db
docker-dev-prepare-db:
	# used for development
	$(DOCKER) exec -T dev-epigraphhub bash /opt/EpiGraphHub/docker/prepare-db.sh

.PHONY:docker-run-cron
docker-run-cron:
	$(DOCKER) exec -T ${SERVICE} bash /opt/EpiGraphHub/Data_Collection/CRON_scripts/owid.sh
	$(DOCKER) exec -T ${SERVICE} bash /opt/EpiGraphHub/Data_Collection/CRON_scripts/foph.sh
	# $(DOCKER) exec -T ${SERVICE} bash /opt/EpiGraphHub/Data_Collection/CRON_scripts/forecast.sh

.PHONY:docker-bash
docker-bash:
	$(DOCKER) exec ${SERVICE} bash
