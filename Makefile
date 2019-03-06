.ONESHELL:
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -c


ENVIRONMENT ?= local

ifeq ($(ENVIRONMENT), local) # if local, then use timestamp over last commit ID to tag Docker image
	export COMMIT := $(shell date +%Y-%m-%d_%H-%M-%S)
	MY_TEST := $(shell minikube docker-env | head -n3 | tail -n1 | cut -d\= -f2)
	export DOCKER_TLS_VERIFY := $(shell minikube docker-env | head -n1 | tail -n1 | cut -d\= -f2)
	export DOCKER_HOST := $(shell minikube docker-env | head -n2 | tail -n1 | cut -d\= -f2)
	export DOCKER_CERT_PATH := $(shell minikube docker-env | head -n3 | tail -n1 | cut -d\= -f2)
	export DOCKER_API_VERSION := $(shell minikube docker-env | head -n4 | tail -n1 | cut -d\= -f2)
endif

include ./properties/$(ENVIRONMENT).properties
export

include mk/*.mk
#include ./mk/project_a.mk
#include ./mk/project_b.mk

tester: test_toast
	export -p | grep DOCKER
	echo $(PROJECT_NAME)
	echo $(COMMIT)
	echo $(MY_TEST)
	$(MAKE) testing

testing:
	echo testing
	export -p | grep DOCKER
	echo $(DOCKER_CERT_PATH)

test_toast:
	echo test_toast
	env | grep DOCKER
	echo $(DOCKER_CERT_PATH)

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
