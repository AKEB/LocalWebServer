#!/bin/sh
# vim:sw=4:ts=4:et

IP=`nslookup host.docker.internal | grep "Address:"  | head -n 2 | tail -n 1 | awk '{print $2}'`

echo "IP=${IP}"

echo "${IP} ${DOMAIN_NAME}" >> /etc/hosts

getent hosts nginx >> /etc/hosts

exit 0
