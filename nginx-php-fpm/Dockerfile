FROM debian:12.5-slim

ARG PHP_VERSION="8.3"
ENV PHP_VERSION=${PHP_VERSION}

ENV TZ=Europe/Moscow

RUN mkdir -p /app \
  && mkdir -p /etc/cron.weekly \
  && mkdir -p /usr/share/GeoIP

WORKDIR /app

USER root

RUN apt-get clean && apt-get dist-upgrade -y \
  && apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
  iputils-ping curl \
  ca-certificates apt-transport-https software-properties-common lsb-release \
  wget nano git sqlite3 iproute2 dnsutils procps mc nginx libnginx-mod-http-geoip

RUN curl -sSL https://packages.sury.org/php/README.txt | bash -x

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
COPY geoip_update.sh /etc/cron.weekly/geoip_update
COPY geoip_update.sh /root/geoip_update.sh

RUN mkdir -p /var/log/nginx/ && touch /var/log/nginx/error.log && touch /var/log/nginx/access.log
RUN mkdir -p /var/log/php/

RUN apt-get clean && apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
  php${PHP_VERSION}-fpm php${PHP_VERSION}-common \
  php${PHP_VERSION}-bcmath \
  php${PHP_VERSION}-curl \
  php${PHP_VERSION}-dom \
  php${PHP_VERSION}-gd \
  php${PHP_VERSION}-igbinary \
  php${PHP_VERSION}-imagick \
  php${PHP_VERSION}-intl \
  php${PHP_VERSION}-mbstring \
  php${PHP_VERSION}-memcached \
  php${PHP_VERSION}-msgpack \
  php${PHP_VERSION}-mysqli \
  php${PHP_VERSION}-mysqlnd \
  php${PHP_VERSION}-sqlite3 \
  php${PHP_VERSION}-zip \
  php${PHP_VERSION}-redis \
  php${PHP_VERSION}-rdkafka \
  php${PHP_VERSION}-bz2 \
  php${PHP_VERSION}-xdebug \
  php${PHP_VERSION}-yaml

RUN apt-get clean && apt-get dist-upgrade -y \
  && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh
RUN touch /run_on_start.sh && chmod +x /run_on_start.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
COPY 00-env.ini /etc/php/${PHP_VERSION}/fpm/conf.d/00-env.ini
COPY 00-env.ini /etc/php/${PHP_VERSION}/cli/conf.d/00-env.ini
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chmod +x /root/geoip_update.sh \
  && chmod +x /etc/cron.weekly/geoip_update \
  && /root/geoip_update.sh \
  && update-ca-certificates -v

CMD ["/bin/bash", "-c", "nginx -g 'daemon on;';/usr/local/etc/hosts.sh;/run_on_start.sh;php-fpm${PHP_VERSION} -F"]

EXPOSE 9000
EXPOSE 80
EXPOSE 443
