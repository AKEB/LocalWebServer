#!/bin/bash

cp ssl/root_ca.crt nginx/ && docker build -t babadzhanyan/nginx:latest ./nginx/ --push

cp ssl/root_ca.crt php-fpm-7_2/ && docker build -t babadzhanyan/php-fpm:7.2 ./php-fpm-7_2/ --push
cp ssl/root_ca.crt php-fpm-7_3/ && docker build -t babadzhanyan/php-fpm:7.3 ./php-fpm-7_3/ --push
cp ssl/root_ca.crt php-fpm-7_4/ && docker build -t babadzhanyan/php-fpm:7.4 ./php-fpm-7_4/ --push
cp ssl/root_ca.crt php-fpm-8_0/ && docker build -t babadzhanyan/php-fpm:8.0 ./php-fpm-8_0/ --push
cp ssl/root_ca.crt php-fpm-8_1/ && docker build -t babadzhanyan/php-fpm:8.1 ./php-fpm-8_1/ --push
cp ssl/root_ca.crt php-fpm-8_2/ && docker build -t babadzhanyan/php-fpm:8.2 ./php-fpm-8_2/ --push