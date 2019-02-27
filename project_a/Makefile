ENVIRONMENT ?= local

include ../properties/$(ENVIRONMENT).properties
export

build:
	docker build --tag=$(PROJECT_A_TAG) .

run:
	docker run -p $(PROJECT_A_PORT):80 $(PROJECT_A_TAG)

run.detached:
	MY_ID=$$(docker container ls | grep $(PROJECT_A_TAG) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test -z $$MY_ID; then docker run -d -p $(PROJECT_A_PORT):80 $(PROJECT_A_TAG); else echo "container is already running ..."; fi

check:
	curl http://localhost:$(PROJECT_A_PORT) | grep "^<h3>Hello World!</h3><b>Hostname:</b> .*<br/><b>Visits:</b> <i>cannot connect to Redis, counter disabled</i>"

stop:
	MY_ID=$$(docker container ls | grep $(PROJECT_A_TAG) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test ! -z $$MY_ID; then docker container stop $$MY_ID; else echo "container is already gone ..."; fi