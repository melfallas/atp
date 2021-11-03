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
CONFIG_PATH="/var/nginx/conf"

#sh ./generate-domain-config.sh $SUBDOMAIN $DOMAIN $PROXY_PORT $CONFIG_PATH

#SUBDOMAIN_PATTERM="app1-ist"
#SUBDOMAIN_PATTERM="name:app1-ist,"
SUBDOMAIN_PATTERM="\"name\":\"app1-ist\","

# Create server name string
SERVER_NAME=$SUBDOMAIN.$DOMAIN
PROXY_LOCATION=http://$DOMAIN:$PROXY_PORT

CONF_FILE_NAME=$SERVER_NAME.conf
echo "|"
echo "Token used: $DGTOKEN"
echo "|"
echo "Consulting existing domains..."
echo "|"
existing_domains=$(curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DGTOKEN" \
  "https://api.digitalocean.com/v2/domains/$DOMAIN/records?type=A&name=$SERVER_NAME"
  )
#  "https://api.digitalocean.com/v2/domains/mbsoftware.ml/records?type=A&name=app1-ist.mbsoftware.ml"
  
echo "$existing_domains"
echo "|"
#echo "$existing_domains" | grep $SUBDOMAIN_PATTERM
#echo "|"
DOMAIN_MATCH=$(echo "$existing_domains" | grep $SUBDOMAIN_PATTERM)
#echo "Match: $DOMAIN_MATCH"
if [ -z "$DOMAIN_MATCH" ]
then
      echo "Not existing domain: $SERVER_NAME"
      echo "Creating domain by API endpoint..."
else
      echo "Establish existing domain: $SERVER_NAME"
fi
#exit 1
echo "Executing by user: "
whoami
/usr/bin/id
echo "|"
cd $CONFIG_PATH
echo "Changing to domain config path: $PWD"
echo "|"
echo "Showing directory permissions:"
ls -l ..
echo "|"
echo "Creating file for domain config: $CONF_FILE_NAME"
touch $CONF_FILE_NAME
echo "|"
echo "Generating domain config for $SERVER_NAME"
echo "|"
#if find / -name art  2>&1 | grep -v "Permission denied"
#then
#	echo "Cannot create file $CONF_FILE_NAME: Permission denied" >&2
#	exit 1
#fi
export DOMAIN_CONFIG_TEXT=$(cat<< EOF
server {
    listen 443;
    listen [::]:443 ipv6only=on;
	
    server_name $SERVER_NAME;
	
    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
	
    location / {
        proxy_pass $PROXY_LOCATION;
    }
}
EOF);
echo "Config file text:"
echo "$DOMAIN_CONFIG_TEXT"
echo "|"
echo "$DOMAIN_CONFIG_TEXT" > $CONF_FILE_NAME
echo "Domain config location stablish on: $PROXY_LOCATION"
echo "|"
cd $ROUTING_DIR
echo "Changing path to routing directory: $PWD"
echo "|"
echo "Reloading proxy server"
echo "|"
#cd $ROUTING_DIR && docker-compose -f docker-compose-nginx-ssl-proxy.yml exec nginx-ssl-proxy-server nginx -s reload
docker-compose -f docker-compose-nginx-ssl-proxy.yml -p WebProxyServer exec -T nginx-ssl-proxy-server nginx -s reload
echo "|"
echo "Finish ..."
echo "|"