FROM debian:12.5-slim

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

RUN apt-get clean && apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
  php8.2-fpm php8.2-common \
  php8.2-bcmath \
  php8.2-curl \
  php8.2-dom \
  php8.2-gd \
  php8.2-igbinary \
  php8.2-imagick \
  php8.2-intl \
  php8.2-mbstring \
  php8.2-memcached \
  php8.2-msgpack \
  php8.2-mysqli \
  php8.2-mysqlnd \
  php8.2-sqlite3 \
  php8.2-zip \
  php8.2-redis \
  php8.2-rdkafka \
  php8.2-bz2 \
  # php8.2-cgi \
  # php8.2-cli \
  # php8.2-decimal \
  # php8.2-dev \
  # php8.2-raphf \
  # php8.2-http \
  # php8.2-ldap \
  # php8.2-mongodb \
  # php8.2-oauth \
  # php8.2-odbc \
  # php8.2-opcache \
  # php8.2-pgsql \
  # php8.2-protobuf \
  # php8.2-smbclient \
  # php8.2-soap \
  # php8.2-ssh2 \
  # php8.2-uuid \
  php8.2-xdebug \
  php8.2-yaml

RUN apt-get clean && apt-get dist-upgrade -y \
  && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh
RUN touch /run_on_start.sh && chmod +x /run_on_start.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/8.2/fpm/php-fpm.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chmod +x /root/geoip_update.sh \
  && chmod +x /etc/cron.weekly/geoip_update \
  && /root/geoip_update.sh \
  && update-ca-certificates -v

CMD ["/bin/bash", "-c", "nginx -g 'daemon on;';/usr/local/etc/hosts.sh;/run_on_start.sh;php-fpm8.2 -F"]

EXPOSE 9000
EXPOSE 80
EXPOSE 443
