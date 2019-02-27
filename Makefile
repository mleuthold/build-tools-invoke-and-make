# The purpose of this file is to handle all sub projects as a single project

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

#build:
#	$(MAKE) test.unit
#	@echo "build for $(ENV)"
#	$(MAKE) test.integration
#
#deploy:
#	@echo "deploy to $(ENV)"
#
#release: deploy
#	@echo "release to $(ENV)"
#	$(MAKE) test.smoke
#	$(MAKE) test.acceptance
#
#test.unit:
#	@echo unit test
#
#test.integration:
#	@echo integration test
#
#test.smoke:
#	@echo smoke test
#
#test.acceptance:
#	@echo acceptance test