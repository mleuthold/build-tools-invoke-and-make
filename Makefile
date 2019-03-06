ENVIRONMENT ?= local

include ./properties/$(ENVIRONMENT).properties
export

include mk/*.mk
#include ./mk/project_a.mk
#include ./mk/project_b.mk

build: \
	build.project_a \
	build.project_b

deploy: \
	run.detached.project_a \
	run.detached.project_b

test: \
	check.project_a \
	check.project_b

undeploy: \
	stop.project_a \
	stop.project_b

wait: wait.3 wait.4 wait.5 wait.6

wait.6:
	sleep 6

wait.5:
	sleep 5

wait.4:
	sleep 4

wait.3:
	sleep 3
