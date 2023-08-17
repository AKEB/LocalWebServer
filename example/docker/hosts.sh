#!/bin/sh
# vim:sw=4:ts=4:et

IP=`getent hosts host.docker.internal | awk '{print $1}'`

echo "IP=${IP}"

echo "${IP} my.example.ru" >> /etc/hosts
echo "${IP} my.example.com" >> /etc/hosts

getent hosts nginx >> /etc/hosts

exit 0
