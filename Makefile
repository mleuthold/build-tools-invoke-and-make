ENVIRONMENT ?= local

include ./properties/$(ENVIRONMENT).properties
export

build:
	$(MAKE) -C project_a build
	$(MAKE) -C project_b build

deploy:
	$(MAKE) -C project_a run.detached
	$(MAKE) -C project_b run.detached

test:
	$(MAKE) -C project_a check
	$(MAKE) -C project_b check

undeploy:
	$(MAKE) -C project_a stop
	$(MAKE) -C project_b stop