build.project_b:
	cd project_b; docker build --tag=$(PROJECT_B_TAG) .

run.project_b:
	docker run -p $(PROJECT_B_PORT):80 $(PROJECT_B_TAG)

run.detached.project_b:
	MY_ID=$$(docker container ls | grep $(PROJECT_B_TAG) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test -z $$MY_ID; then docker run -d -p $(PROJECT_B_PORT):80 $(PROJECT_B_TAG); else echo "container is already running ..."; fi

check.project_b:
	curl http://localhost:$(PROJECT_B_PORT) | grep "^<h3>Hello World!</h3><b>Hostname:</b> .*<br/><b>Visits:</b> <i>cannot connect to Redis, counter disabled</i>"

stop.project_b:
	MY_ID=$$(docker container ls | grep $(PROJECT_B_TAG) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test ! -z $$MY_ID; then docker container stop $$MY_ID; else echo "container is already gone ..."; fi