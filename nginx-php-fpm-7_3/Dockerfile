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
  php7.3-fpm php7.3-common \
  php7.3-bcmath \
  php7.3-curl \
  php7.3-dom \
  php7.3-gd \
  php7.3-igbinary \
  php7.3-imagick \
  php7.3-intl \
  php7.3-mbstring \
  php7.3-memcached \
  php7.3-msgpack \
  php7.3-mysqli \
  php7.3-mysqlnd \
  php7.3-sqlite3 \
  php7.3-zip \
  php7.3-redis \
  php7.3-rdkafka \
  php7.3-bz2 \
  # php7.3-cgi \
  # php7.3-cli \
  # php7.3-decimal \
  # php7.3-dev \
  # php7.3-raphf \
  # php7.3-http \
  # php7.3-ldap \
  # php7.3-mongodb \
  # php7.3-oauth \
  # php7.3-odbc \
  # php7.3-opcache \
  # php7.3-pgsql \
  # php7.3-smbclient \
  # php7.3-soap \
  # php7.3-ssh2 \
  # php7.3-uuid \
  php7.3-xdebug \
  php7.3-yaml

RUN apt-get clean && apt-get dist-upgrade -y \
  && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh
RUN touch /run_on_start.sh && chmod +x /run_on_start.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chmod +x /root/geoip_update.sh \
  && chmod +x /etc/cron.weekly/geoip_update \
  && /root/geoip_update.sh \
  && update-ca-certificates -v

CMD ["/bin/bash", "-c", "nginx -g 'daemon on;';/usr/local/etc/hosts.sh;/run_on_start.sh;php-fpm7.3 -F"]

EXPOSE 9000
EXPOSE 80
EXPOSE 443
