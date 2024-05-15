FROM debian:12.5-slim

ENV TZ=Europe/Moscow

WORKDIR /var/www/html

USER root

RUN apt-get clean && apt-get dist-upgrade \
	&& apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
    iputils-ping curl mc \
    ca-certificates apt-transport-https software-properties-common lsb-release \
    wget nano git sqlite3

RUN curl -sSL https://packages.sury.org/php/README.txt | bash -x

RUN apt-get clean && apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
    php7.4-fpm php7.4-common \
    php7.4-bcmath \
    php7.4-curl \
    php7.4-dom \
    php7.4-gd \
    php7.4-igbinary \
    php7.4-imagick \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-memcached \
    php7.4-msgpack \
    php7.4-mysqli \
    php7.4-mysqlnd \
    php7.4-sqlite3 \
    php7.4-zip \
    php7.4-redis \
    php7.4-rdkafka \
    php7.4-bz2 \
    php7.4-cgi \
    php7.4-cli \
    php7.4-decimal \
    php7.4-dev \
    php7.4-raphf \
    php7.4-http \
    php7.4-ldap \
    php7.4-mongodb \
    php7.4-oauth \
    php7.4-odbc \
    php7.4-opcache \
    php7.4-pgsql \
    php7.4-smbclient \
    php7.4-soap \
    php7.4-ssh2 \
    php7.4-uuid \
    php7.4-xdebug \
    php7.4-yaml

RUN apt-get clean && apt-get dist-upgrade \
    && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY www.conf /usr/etc/php-fpm.d/www.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["/bin/bash", "-c", "/usr/local/etc/hosts.sh;php-fpm7.4 -F"]

EXPOSE 9000
