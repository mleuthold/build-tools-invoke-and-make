.ONESHELL:
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -c


ENVIRONMENT ?= local

ifeq ($(ENVIRONMENT), local) # if local, then use timestamp over last commit ID to tag Docker image
	export COMMIT := $(shell date +%Y-%m-%d_%H-%M-%S)
	MY_TEST := $(shell minikube docker-env | head -n3 | tail -n1 | cut -d\= -f2)
	export DOCKER_TLS_VERIFY := $(shell minikube docker-env | grep DOCKER_TLS_VERIFY | cut -d\= -f2)
	export DOCKER_HOST := $(shell minikube docker-env | grep DOCKER_HOST | cut -d\= -f2)
	export DOCKER_CERT_PATH := $(shell minikube docker-env | grep DOCKER_CERT_PATH | cut -d\= -f2)
	export DOCKER_API_VERSION := $(shell minikube docker-env | grep DOCKER_API_VERSION | cut -d\= -f2)
	export MY_CONTEXT := $(shell kubectl config use-context minikube; echo "YAY")
endif

include ./properties/$(ENVIRONMENT).properties
export

include mk/*.mk
#include ./mk/project_a.mk
#include ./mk/project_b.mk

%::
	kubectl config current-context

tester: test_toast test_toast2
	echo MY_CONTEXT $(MY_CONTEXT)
	export -p | grep DOCKER
	kubectl config current-context
#	echo $(PROJECT_NAME)
#	echo $(COMMIT)
#	echo $(MY_TEST)
#	$(MAKE) testing

testing:
	echo testing
	export -p | grep DOCKER
	echo $(DOCKER_CERT_PATH)

test_toast:
	echo test_toast
	env | grep DOCKER

test_toast2:
	echo test_toast2
	env | grep DOCKER

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

wait: wait.0 wait.3 wait.4 wait.5 wait.6

wait.0:
	kubectl config use-context minikube.internal

wait.6:
	kubectl config current-context
	sleep 6
	#kubectl config use-context minikube.internal

wait.5:
	kubectl config current-context
	sleep 5
	#kubectl config use-context minikube

wait.4:
	kubectl config current-context
	sleep 4
	#kubectl config use-context minikube.internal

wait.3:
	kubectl config current-context
	sleep 3
	#kubectl config use-context minikube
