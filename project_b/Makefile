ENVIRONMENT ?= local

include ../properties/$(ENVIRONMENT).properties
export

build:
	docker build --tag=$(PROJECT_B_TAG) .

run:
	docker run -p $(PROJECT_B_PORT):80 $(PROJECT_B_TAG)

run.detached:
	MY_ID=$$(docker container ls | grep $(PROJECT_B_TAG) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test -z $$MY_ID; then docker run -d -p $(PROJECT_B_PORT):80 $(PROJECT_B_TAG); else echo "container is already running ..."; fi

check:
	curl http://localhost:$(PROJECT_B_PORT) | grep "^<h3>Hello World!</h3><b>Hostname:</b> .*<br/><b>Visits:</b> <i>cannot connect to Redis, counter disabled</i>"

stop:
	MY_ID=$$(docker container ls | grep $(PROJECT_B_TAG) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test ! -z $$MY_ID; then docker container stop $$MY_ID; else echo "container is already gone ..."; fi