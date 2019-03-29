get_conf = $$(yq $(1) configs/$(ENVIRONMENT).yaml -r)

build.project_a:
	docker build --tag=$(call get_conf,.project_a.tag) project_a

run.project_a:
	docker run -p $(call get_conf,.project_a.port):80 $(call get_conf,.project_a.tag)

run.detached.project_a:
	MY_ID=$$(docker container ls | grep $(call get_conf,.project_a.tag) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test -z $$MY_ID; then docker run -d -p $(call get_conf,.project_a.port):80 $(call get_conf,.project_a.tag); else echo "container is already running ..."; fi

check.project_a:
	curl http://localhost:$(call get_conf,.project_a.port) | grep "^<h3>Hello World!</h3><b>Hostname:</b> .*<br/><b>Visits:</b> <i>cannot connect to Redis, counter disabled</i>"

stop.project_a:
	MY_ID=$$(docker container ls | grep $(call get_conf,.project_a.tag) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test ! -z $$MY_ID; then docker container stop $$MY_ID; else echo "container is already gone ..."; fi