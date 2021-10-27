#!/bin/bash

#export REGISTRY="localhost:5000"
export DEPLOY_DIR="/var/jenkins_home/deploy"

export IMAGE=$(sed -n '1p' /tmp/.auth)
export TAG=$(sed -n '2p' /tmp/.auth)
export CONTAINER_NAME=$(sed -n '3p' /tmp/.auth)
export ENV=$(sed -n '4p' /tmp/.auth)
export HOST_PORT=$(sed -n '5p' /tmp/.auth)
export DOCKER_PORT=$(sed -n '6p' /tmp/.auth)

#export spring.profiles.active=$ENV

#export IMAGE=$(sed -n '1p' /var/jenkins_home/jenkins_deploy/.appvar)
#export TAG=$(sed -n '2p' /var/jenkins_home/jenkins_deploy/.appvar)
echo Space establecido en $ENV
echo Variable IMAGE establecida en $IMAGE
echo Variable TAG establecida en $TAG
echo Variable HOST_PORT establecida en $HOST_PORT
echo Variable DOCKER_PORT establecida en $DOCKER_PORT
echo Ruta actual: $PWD
#cd ../jenkins_deploy && docker-compose up -d
#cd ~/jenkins/jenkins_deploy && docker-compose up -d
#cd ~/jenkins_deploy && docker-compose up -d
cd $DEPLOY_DIR && docker-compose -f docker-compose-deploy.yml up -d
#cd /home/admin1/jenkins/jenkins_deploy && docker-compose up -d
