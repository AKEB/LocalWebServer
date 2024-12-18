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
    php8.1-fpm php8.1-common \
    php8.1-bcmath \
    php8.1-curl \
    php8.1-dom \
    php8.1-gd \
    php8.1-igbinary \
    php8.1-imagick \
    php8.1-intl \
    php8.1-mbstring \
    php8.1-memcached \
    php8.1-msgpack \
    php8.1-mysqli \
    php8.1-mysqlnd \
    php8.1-sqlite3 \
    php8.1-zip \
    php8.1-redis \
    php8.1-rdkafka \
    php8.1-bz2 \
    # php8.1-cgi \
    # php8.1-cli \
    # php8.1-decimal \
    # php8.1-dev \
    # php8.1-raphf \
    # php8.1-http \
    # php8.1-ldap \
    # php8.1-mongodb \
    # php8.1-oauth \
    # php8.1-odbc \
    # php8.1-opcache \
    # php8.1-pgsql \
    # php8.1-protobuf \
    # php8.1-smbclient \
    # php8.1-soap \
    # php8.1-ssh2 \
    # php8.1-uuid \
    php8.1-xdebug \
    php8.1-yaml

RUN apt-get clean && apt-get dist-upgrade -y \
    && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh
RUN touch /run_on_start.sh && chmod +x /run_on_start.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/8.1/fpm/php-fpm.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["/bin/bash", "-c", "/usr/local/etc/hosts.sh;/run_on_start.sh;php-fpm8.1 -F"]

EXPOSE 9000
