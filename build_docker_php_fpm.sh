#!/bin/bash

# Nginx
cp ${PWD}/ssl/root_ca.crt ${PWD}/nginx/ && docker buildx build  \
--push \
--platform linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/mips64le,linux/ppc64le,linux/s390x \
--tag babadzhanyan/nginx:latest ${PWD}/nginx/

# PHP 7.2
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-7_2/ && docker buildx build \
--push \
--platform linux/amd64,linux/arm/v7,linux/arm64/v8 \
--tag babadzhanyan/php-fpm:7.2 ${PWD}/php-fpm-7_2/ 

# PHP 7.3
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-7_3/ && docker buildx build \
--push \
--platform linux/amd64,linux/arm/v7,linux/arm64/v8 \
--tag babadzhanyan/php-fpm:7.3 ${PWD}/php-fpm-7_3/ 

# PHP 7.4
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-7_4/ && docker buildx build \
--push \
--platform linux/amd64,linux/arm/v7,linux/arm64/v8 \
--tag babadzhanyan/php-fpm:7.4 ${PWD}/php-fpm-7_4/

# PHP 8.0
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-8_0/ && docker buildx build \
--push \
--platform linux/amd64,linux/arm/v7,linux/arm64/v8 \
--tag babadzhanyan/php-fpm:8.0 ${PWD}/php-fpm-8_0/

# PHP 8.1
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-8_1/ && docker buildx build \
--push \
--platform linux/amd64,linux/arm/v7,linux/arm64/v8 \
--tag babadzhanyan/php-fpm:8.1 ${PWD}/php-fpm-8_1/

# PHP 8.2
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-8_2/ && docker buildx build \
--push \
--platform linux/amd64,linux/arm/v7,linux/arm64/v8 \
--tag babadzhanyan/php-fpm:8.2 ${PWD}/php-fpm-8_2/

# PHP 8.3
cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm-8_3/ && docker buildx build \
--push \
--platform linux/amd64,linux/arm/v7,linux/arm64/v8 \
--tag babadzhanyan/php-fpm:8.3 ${PWD}/php-fpm-8_3/
