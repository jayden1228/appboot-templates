SHELL := /bin/bash
BASEDIR = $(shell pwd)

APP_NAME={{.Name}}
APP_VERSION=1.0.0
IMAGE_NAME="{{.DockerGroup}}/${APP_NAME}:${APP_VERSION}"

build:
	echo ${IMAGE_NAME}; \
	docker build -t ${IMAGE_NAME} -f Dockerfile .;
push: build
	docker push ${IMAGE_NAME};
help:
	@echo "build - build docker image"
	@echo "push - push docker image to docker"