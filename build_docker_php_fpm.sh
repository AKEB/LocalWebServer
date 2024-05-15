#!/bin/bash

cp ${PWD}/ssl/root_ca.crt ${PWD}/nginx/
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-7_2/
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-7_3/
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-7_4/
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-8_0/
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-8_1/
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-8_2/
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-8_3/

rm -rf ${PWD}/jobs/*.*
mkdir -p ${PWD}/jobs/

# Nginx
# docker buildx build  \
# --push \
# --platform linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/mips64le,linux/ppc64le,linux/s390x \
# --tag babadzhanyan/nginx:latest ${PWD}/nginx/
docker build --tag babadzhanyan/nginx:latest ${PWD}/nginx/ > ${PWD}/jobs/nginx.log 2>&1 &

# PHP 7.2
docker build --tag babadzhanyan/php-fpm:7.2 ${PWD}/php-fpm-7_2/ > ${PWD}/jobs/php-fpm-7_2.log 2>&1 &

# PHP 7.3
docker build --tag babadzhanyan/php-fpm:7.3 ${PWD}/php-fpm-7_3/ > ${PWD}/jobs/php-fpm-7_3.log 2>&1 &

# PHP 7.4
docker build --tag babadzhanyan/php-fpm:7.4 ${PWD}/php-fpm-7_4/ > ${PWD}/jobs/php-fpm-7_4.log 2>&1 &

# PHP 8.0
docker build --tag babadzhanyan/php-fpm:8.0 ${PWD}/php-fpm-8_0/ > ${PWD}/jobs/php-fpm-8_0.log 2>&1 &

# PHP 8.1
docker build --tag babadzhanyan/php-fpm:8.1 ${PWD}/php-fpm-8_1/ > ${PWD}/jobs/php-fpm-8_1.log 2>&1 &

# PHP 8.2
docker build --tag babadzhanyan/php-fpm:8.2 ${PWD}/php-fpm-8_2/ > ${PWD}/jobs/php-fpm-8_2.log 2>&1 &

# PHP 8.3
docker build --tag babadzhanyan/php-fpm:8.3 ${PWD}/php-fpm-8_3/ > ${PWD}/jobs/php-fpm-8_3.log 2>&1 &

wait
