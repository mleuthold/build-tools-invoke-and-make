build.project_a:
	docker build --tag=$$(yq .project_a.tag configs/$(ENVIRONMENT).yaml -r) project_a

run.project_a:
	docker run -p $$(yq .project_a.port configs/$(ENVIRONMENT).yaml -r):80 $$(yq .project_a.tag configs/$(ENVIRONMENT).yaml -r)

run.detached.project_a:
	MY_ID=$$(docker container ls | grep $$(yq .project_a.tag configs/$(ENVIRONMENT).yaml -r) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test -z $$MY_ID; then docker run -d -p $$(yq .project_a.port configs/$(ENVIRONMENT).yaml -r):80 $$(yq .project_a.tag configs/$(ENVIRONMENT).yaml -r); else echo "container is already running ..."; fi

check.project_a:
	curl http://localhost:$$(yq .project_a.port configs/$(ENVIRONMENT).yaml -r) | grep "^<h3>Hello World!</h3><b>Hostname:</b> .*<br/><b>Visits:</b> <i>cannot connect to Redis, counter disabled</i>"

stop.project_a:
	MY_ID=$$(docker container ls | grep $$(yq .project_a.tag configs/$(ENVIRONMENT).yaml -r) | awk '{print $$1}'); \
	echo "MY_ID: $$MY_ID"; \
	if test ! -z $$MY_ID; then docker container stop $$MY_ID; else echo "container is already gone ..."; fi