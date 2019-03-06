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

undeploy:
	stop.project_a \
	stop.project_b
