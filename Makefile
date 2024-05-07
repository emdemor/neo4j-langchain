-include .env

export

PROJECT_NAME := neo4j_ia

NEO4J_IMAGE := $(PROJECT_NAME)_gdb
JUPYTER_IMAGE := $(PROJECT_NAME)_jupyter

DOCKER_COMPOSE_FILEPATH := docker/docker-compose.yml
JUPYTER_DOCKERFILE_PATH := docker/Dockerfile.jupyter
# NEO4J_DOCKERFILE_PATH := docker/Dockerfile.neo4j

NEO4J_PORT ?= 7474
# CHROMA_PORT ?= 8000
JUPYTER_PORT ?= 8888
# FRONT_PORT ?= 8501

DOCKER_RUN := docker run --rm -t
DOCKER_RUN_ITERACTIVE := $(DOCKER_RUN) -i
DOCKER_ENV := --env-file .env
DOCKER_COMPOSE := docker-compose -f $(DOCKER_COMPOSE_FILEPATH)

RUNNING_CONTAINERS = $(docker ps -a -q)

build: build-jupyter

build-jupyter:
	docker build -f $(JUPYTER_DOCKERFILE_PATH) -t $(JUPYTER_IMAGE) .

up:
	$(DOCKER_COMPOSE) up --build

down:
	$(DOCKER_COMPOSE) down


# run-jupyter:
# 	$(RUN_JUPYTER)

# shell-jupyter:
# 	$(DOCKER_RUN_ITERACTIVE) $(DOCKER_ENV) -p $(JUPYTER_PORT):$(JUPYTER_PORT) $(JUPYTER_IMAGE) /bin/bash

# build-front:
# 	docker build -f $(FRONT_DOCKERFILE_PATH) -t $(FRONT_IMAGE) .
	
# front:
# 	$(RUN_FRONT)

# shell-front:
# 	$(DOCKER_RUN_ITERACTIVE) $(DOCKER_ENV) -p $(FRONT_PORT):$(FRONT_PORT) $(FRONT_IMAGE) /bin/bash

# update-vdb:
# 	dvc add database
# 	git add database.dvc .gitignore
# 	git commit -m "update database"

# load-vdb:
# 	dvc pull