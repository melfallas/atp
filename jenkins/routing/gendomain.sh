#!/bin/bash

export ROUTING_DIR="/var/jenkins_home/workspace/pipeline-maven-test/jenkins/routing"

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
CONFIG_PATH="/var/nginx"

#sh ./generate-domain-config.sh $SUBDOMAIN $DOMAIN $PROXY_PORT $CONFIG_PATH

# Create server name string
SERVER_NAME=$SUBDOMAIN.$DOMAIN
PROXY_LOCATION=http://$DOMAIN:$PROXY_PORT
CONF_FILE_NAME=$SERVER_NAME.conf

# Invoke config template
#sh ./domain-config-template.sh $SUBDOMAIN $DOMAIN $PROXY_LOCATION > $CONFIG_PATH/$CONF_FILE_NAME
echo "Executing by user: "
whoami
/usr/bin/id
echo "|"
cd $CONFIG_PATH
echo "|"
echo "Domain config path: $PWD"
touch $CONF_FILE_NAME
echo "|"
echo "Generating domain config for $SERVER_NAME"
echo "|"
#if find / -name art  2>&1 | grep -v "Permission denied"
#then
#	echo "Cannot create file $CONF_FILE_NAME: Permission denied" >&2
#	exit 1
#fi
cat  << EOF
server {
    listen 443 default_server;
    listen [::]:443 default_server ipv6only=on;
	
    server_name $SERVER_NAME;
	
    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
	
    location / {
        proxy_pass $PROXY_LOCATION;
    }
}
EOF
> $CONF_FILE_NAME

echo "Domain config location stablish on: $PROXY_LOCATION"
echo "|"
cd $ROUTING_DIR
echo "Changin path to routing directory: $PWD"
echo "|"
echo "Reloading proxy server"
echo "|"
#cd $ROUTING_DIR && docker-compose -f docker-compose-nginx-ssl-proxy.yml exec nginx-ssl-proxy-server nginx -s reload
docker-compose -f docker-compose-nginx-ssl-proxy.yml exec nginx-ssl-proxy-server nginx -s reload
echo "|"
echo "Finish ..."
echo "|"