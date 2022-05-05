SERVICES:=epigraphhub-superset
SERVICE:=epigraphhub-superset
# options: dev, prod
ENV:=dev

DOCKER=docker-compose \
	--env-file .env \
	--project-name eph-$(ENV) \
	--file docker/compose-base.yaml \
	--file docker/compose-$(ENV).yaml

# DOCKER

.PHONY:docker-build
docker-build:
	$(DOCKER) build ${SERVICES}
	$(DOCKER) pull ${SERVICES}


.PHONY:docker-start
docker-start:
	$(DOCKER) up -d ${SERVICES}


.PHONY:docker-stop
docker-stop:
	$(DOCKER) stop ${SERVICES}


.PHONY:docker-restart
docker-restart: docker-stop docker-start
	echo "[II] Docker services restarted!"


.PHONY:docker-logs
docker-logs:
	$(DOCKER) logs --follow --tail 100 ${SERVICES}

.PHONY: docker-wait
docker-wait:
	echo ${SERVICES} | xargs -t -n1 ./docker/healthcheck.sh

.PHONY:docker-dev-prepare-db
docker-dev-prepare-db:
	# used for development
	$(DOCKER) exec -T epigraphhub \
		bash /opt/EpiGraphHub/docker/postgresql/prepare-db.sh


.PHONY:docker-run-cron
docker-run-cron:
	$(DOCKER) exec -T ${SERVICE} bash \
		/opt/EpiGraphHub/Data_Collection/CRON_scripts/owid.sh
	$(DOCKER) exec -T ${SERVICE} bash \
		/opt/EpiGraphHub/Data_Collection/CRON_scripts/foph.sh
	# $(DOCKER) exec -T ${SERVICE} bash \
	# 	/opt/EpiGraphHub/Data_Collection/CRON_scripts/forecast.sh


.PHONY:docker-bash
docker-bash:
	$(DOCKER) exec ${SERVICE} bash

.PHONY:docker-run-bash
docker-run-bash:
	$(DOCKER) run --rm ${SERVICE} bash


# ANSIBLE

.PHONY:deploy
deploy:
	ansible-playbook -vv \
		-i ansible/inventories/hosts.ini \
		--vault-password-file .vault_pass.txt \
		ansible/deployment.yml


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
