#!/bin/bash

echo ""
echo "#########################"
echo "*  Preparing to deploy  *"
echo "#########################"
echo ""

CONTAINER_NAME=$1
ENVIRONMENT=$2
HOST_PORT=$3
DOCKER_PORT=$4
# Generamos archivo con variables
echo $IMAGE_NAME > /tmp/.auth
echo $BUILD_NUMBER >> /tmp/.auth
echo $CONTAINER_NAME >> /tmp/.auth
echo $ENVIRONMENT >> /tmp/.auth
echo $HOST_PORT >> /tmp/.auth
echo $DOCKER_PORT >> /tmp/.auth

#echo $IMAGE_NAME > ~/jenkins/jenkins_home/jenkins_deploy/.appvar
#echo $BUILD_TAG >> ~/jenkins/jenkins_home/jenkins_deploy/.appvar

# Ejecuta el archivo para publish
#. publish_local.sh