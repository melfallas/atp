#!/bin/bash

#export REGISTRY="localhost:5000"
export DEPLOY_DIR="/var/jenkins_home/deploy"

export IMAGE=$(sed -n '1p' /tmp/.auth)
export TAG=$(sed -n '2p' /tmp/.auth)
export CONTAINER_NAME=$(sed -n '3p' /tmp/.auth)
export ENV=$(sed -n '4p' /tmp/.auth)
export HOST_PORT=$(sed -n '5p' /tmp/.auth)
export DOCKER_PORT=$(sed -n '6p' /tmp/.auth)

# Default constanst
SUBDOMAIN=$CONTAINER_NAME-$ENV
DOMAIN="mbsoftware.ml"
PROXY_PORT=$HOST_PORT
CONFIG_PATH="/home/admin1/docker/volumes/web/nginx/conf"

sh ./generate-domain-config.sh $SUBDOMAIN $DOMAIN $PROXY_PORT $CONFIG_PATH
