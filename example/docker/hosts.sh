#!/bin/sh
# vim:sw=4:ts=4:et

IP=`getent hosts host.docker.internal | awk '{print $1}'`

echo "IP=${IP}"

echo "${IP} ${DOMAIN_NAME}" >> /etc/hosts

getent hosts nginx >> /etc/hosts

exit 0
