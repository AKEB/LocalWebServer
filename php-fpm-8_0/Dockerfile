FROM debian:12.5-slim

ENV TZ=Europe/Moscow

WORKDIR /app

USER root

RUN apt-get clean && apt-get dist-upgrade -y \
	&& apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
  iputils-ping curl \
  ca-certificates apt-transport-https software-properties-common lsb-release \
  wget nano git sqlite3 iproute2 dnsutils

RUN curl -sSL https://packages.sury.org/php/README.txt | bash -x

RUN apt-get clean && apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
    php8.0-fpm php8.0-common \
    php8.0-bcmath \
    php8.0-curl \
    php8.0-dom \
    php8.0-gd \
    php8.0-igbinary \
    php8.0-imagick \
    php8.0-intl \
    php8.0-mbstring \
    php8.0-memcached \
    php8.0-msgpack \
    php8.0-mysqli \
    php8.0-mysqlnd \
    php8.0-sqlite3 \
    php8.0-zip \
    php8.0-redis \
    php8.0-rdkafka \
    php8.0-bz2 \
    # php8.0-cgi \
    # php8.0-cli \
    # php8.0-decimal \
    # php8.0-dev \
    # php8.0-raphf \
    # php8.0-http \
    # php8.0-ldap \
    # php8.0-mongodb \
    # php8.0-oauth \
    # php8.0-odbc \
    # php8.0-opcache \
    # php8.0-pgsql \
    # php8.0-protobuf \
    # php8.0-smbclient \
    # php8.0-soap \
    # php8.0-ssh2 \
    # php8.0-uuid \
    php8.0-xdebug \
    php8.0-yaml

RUN apt-get clean && apt-get dist-upgrade -y \
    && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh
RUN touch /run_on_start.sh && chmod +x /run_on_start.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["/bin/bash", "-c", "/usr/local/etc/hosts.sh;/run_on_start.sh;php-fpm8.0 -F"]

EXPOSE 9000
