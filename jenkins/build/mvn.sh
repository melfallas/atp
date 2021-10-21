#!/bin/bash

# Validación de parámetros
mvnComand1=$1
mvnComand2=$2
mvnComand3=$3
mvnComand4=$4
mvnComand5=$5
appDir=$6

if [ -z ${appDir} ]; then 
	echo ""
	echo Debe especificar el directorio java
	echo ""
else
	echo ""
	echo "****************"
	echo "* Building jar!*"
	echo "****************"
	echo ""
	#docker run --rm -v /root/.m2:/root/.m2 -v $appDir:/app -w /app maven:3-alpine "$mvnComand1" "$mvnComand2"
	docker run --rm -v /root/.m2:/root/.m2 -v $appDir:/app -w /app maven:3-alpine "$mvnComand1" "$mvnComand2" "$mvnComand3" "$mvnComand4" "$mvnComand5"
fi


#PROJ=$PWD
#docker run --rm -v /root/.m2:/root/.m2 -v $PROJ/java-app:/app -w /app maven:3-alpine "$@"
