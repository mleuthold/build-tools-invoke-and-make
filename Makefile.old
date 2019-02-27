ENVIRONMENT ?= local

include ./properties/$(ENVIRONMENT).properties
export

build:
	$(MAKE) test.unit
	@echo "build for $(ENV)"
	$(MAKE) test.integration

deploy:
	@echo "deploy to $(ENV)"

release: deploy
	@echo "release to $(ENV)"
	$(MAKE) test.smoke
	$(MAKE) test.acceptance

test.unit:
	@echo unit test

test.integration:
	@echo integration test

test.smoke:
	@echo smoke test

test.acceptance:
	@echo acceptance test