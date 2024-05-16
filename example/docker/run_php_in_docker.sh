#!/bin/bash

HOST_DIR=${1}/
DOCKER_DIR="/var/www/html/"
SCRIPT_DIR=`dirname ${2}`/
FILE_NAME=${2/"$SCRIPT_DIR"/""}
SCRIPT_DIR=${SCRIPT_DIR/"$HOST_DIR"/""}

ARGS=''
for ((argnum = 3; argnum <= $#; argnum++)); do
  ARGS="${ARGS}${!argnum} "
done

# echo "/usr/local/bin/docker compose -f ${HOST_DIR}/docker/docker-compose.yml exec -t php-fpm bash -c \"cd ${DOCKER_DIR}${SCRIPT_DIR} && php ${FILE_NAME} ${ARGS}\""
/usr/local/bin/docker compose -f ${HOST_DIR}/docker/docker-compose.yml exec -t php-fpm bash -c "cd ${DOCKER_DIR}${SCRIPT_DIR} && php ${FILE_NAME} ${ARGS}"
