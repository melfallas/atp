#!/bin/bash

# Validación de parámetros
appDir=$1 
#appDir=java-app
if [ -z ${appDir} ]; then 
	echo "|"
	echo Debe especificar el directorio java
	echo "|"
else
	echo "|"
	echo "Executing by user: "
	whoami
	/usr/bin/id
	echo "|"
	echo "Removing existing *.jar files ..."
	echo "|"
	echo "Dir original permissions ${appDir}:"
	ls -l ${appDir}
	echo "|"
	echo "Getting *.jar files of /target directory ..."
	ls -l ${appDir}/target
	#echo "Borrando adicionales de directorio ${appDir}/target..."
	#rm -f silo-0.0.1-SNAPSHOT.jar.original
	#ls -l ${appDir}/target
	# Copiar el jar	
	echo "|"
	echo "Copy *.jar files to jenkins/build directory ..."
	#cp -f "$appDir"/target/silo-0.0.1-SNAPSHOT.jar jenkins/build/
	cp -f "$appDir"/target/*.jar jenkins/build/
	echo ""
	echo "######################"
	echo "*** Building image ***"
	echo "######################"
	echo ""
	cd jenkins/build/ && docker-compose -f docker-compose-build.yml build --no-cache
	echo "|"
	echo "Removing pending images ..."
	echo "docker rmi $(docker images -f "dangling=true" -q --no-trunc)"
fi

