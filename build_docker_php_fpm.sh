#!/bin/bash

cp ${PWD}/ssl/root_ca.crt ${PWD}/nginx/

cp ${PWD}/ssl/root_ca.crt ${PWD}/php-fpm/
cp ${PWD}/ssl/root_ca.crt ${PWD}/nginx-php-fpm/

rm -rf ${PWD}/build/*.*
mkdir -p ${PWD}/build/

FAIL=0
echo "Starting buildings..."


# Nginx
# --push \
# --platform linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/mips64le,linux/ppc64le,linux/s390x \
# docker build \
#   --tag akeb/nginx:latest \
#   ${PWD}/nginx/ > ${PWD}/build/nginx.log 2>&1 &

# # PHP 7.1
# docker build \
#   --tag akeb/php-fpm-7.1:latest \
#   --build-arg PHP_VERSION=7.1 \
#   ${PWD}/php-fpm/ > ${PWD}/build/php-fpm-7_1.log 2>&1 &

# # PHP 7.2
# docker build \
#   --tag akeb/php-fpm-7.2:latest \
#   --build-arg PHP_VERSION=7.2 \
#   ${PWD}/php-fpm/ > ${PWD}/build/php-fpm-7_2.log 2>&1 &

# # PHP 7.3
# docker build \
#   --tag akeb/php-fpm-7.3:latest \
#   --build-arg PHP_VERSION=7.3 \
#   ${PWD}/php-fpm/ > ${PWD}/build/php-fpm-7_3.log 2>&1 &

# # PHP 7.4
# docker build \
#   --tag akeb/php-fpm-7.4:latest \
#   --build-arg PHP_VERSION=7.4 \
#   ${PWD}/php-fpm/ > ${PWD}/build/php-fpm-7_4.log 2>&1 &


# # PHP 8.0
# docker build \
#   --tag akeb/php-fpm-8.0:latest \
#   --build-arg PHP_VERSION=8.0 \
#   ${PWD}/php-fpm/ > ${PWD}/build/php-fpm-8_0.log 2>&1 &

# # PHP 8.1
# docker build \
#   --tag akeb/php-fpm-8.1:latest \
#   --build-arg PHP_VERSION=8.1 \
#   ${PWD}/php-fpm/ > ${PWD}/build/php-fpm-8_1.log 2>&1 &

# # PHP 8.2
# docker build \
#   --tag akeb/php-fpm-8.2:latest \
#   --build-arg PHP_VERSION=8.2 \
#   ${PWD}/php-fpm/ > ${PWD}/build/php-fpm-8_2.log 2>&1 &

# # PHP 8.3
# docker build \
#   --tag akeb/php-fpm-8.3:latest \
#   --build-arg PHP_VERSION=8.3 \
#   ${PWD}/php-fpm/ > ${PWD}/build/php-fpm-8_3.log 2>&1 &


# NGINX PHP 7.1
# docker build \
#   --tag akeb/nginx-php-fpm-7.1:latest \
#   --build-arg PHP_VERSION=7.1 \
#   ${PWD}/nginx-php-fpm/ > ${PWD}/build/nginx-php-fpm-7_1.log 2>&1 &

# NGINX PHP 7.2
# docker build \
#   --tag akeb/nginx-php-fpm-7.2:latest \
#   --build-arg PHP_VERSION=7.2 \
#   ${PWD}/nginx-php-fpm/ > ${PWD}/build/nginx-php-fpm-7_2.log 2>&1 &

# NGINX PHP 7.3
# docker build \
#   --tag akeb/nginx-php-fpm-7.3:latest \
#   --build-arg PHP_VERSION=7.3 \
#   ${PWD}/nginx-php-fpm/ > ${PWD}/build/nginx-php-fpm-7_3.log 2>&1 &

# NGINX PHP 7.4
# docker build \
#   --tag akeb/nginx-php-fpm-7.4:latest \
#   --build-arg PHP_VERSION=7.4 \
#   ${PWD}/nginx-php-fpm/ > ${PWD}/build/nginx-php-fpm-7_4.log 2>&1 &

# NGINX PHP 8.0
# docker build \
#   --tag akeb/nginx-php-fpm-8.0:latest \
#   --build-arg PHP_VERSION=8.0 \
#   ${PWD}/nginx-php-fpm/ > ${PWD}/build/nginx-php-fpm-8_0.log 2>&1 &


# NGINX PHP 8.1
# docker build \
#   --tag akeb/nginx-php-fpm-8.1:latest \
#   --build-arg PHP_VERSION=8.1 \
#   ${PWD}/nginx-php-fpm/ > ${PWD}/build/nginx-php-fpm-8_1.log 2>&1 &


# NGINX PHP 8.2
# docker build \
#   --tag akeb/nginx-php-fpm-8.2:latest \
#   --build-arg PHP_VERSION=8.2 \
#   ${PWD}/nginx-php-fpm/ > ${PWD}/build/nginx-php-fpm-8_2.log 2>&1 &

# NGINX PHP 8.3
docker build \
  --tag akeb/nginx-php-fpm-8.3:latest \
  --build-arg PHP_VERSION=8.3 \
  ${PWD}/nginx-php-fpm/ > ${PWD}/build/nginx-php-fpm-8_3.log 2>&1 &



for job in `jobs -p`
do
   wait $job || let "FAIL+=1"
done

if [ "$FAIL" == "0" ];
then
    echo "All jobs completed!"
else
    echo "Jobs FAILED: ($FAIL)"
fi
