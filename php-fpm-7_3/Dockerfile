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
    php7.3-cgi \
    php7.3-cli \
    php7.3-decimal \
    php7.3-dev \
    php7.3-raphf \
    php7.3-http \
    php7.3-ldap \
    php7.3-mongodb \
    php7.3-oauth \
    php7.3-odbc \
    php7.3-opcache \
    php7.3-pgsql \
    php7.3-smbclient \
    php7.3-soap \
    php7.3-ssh2 \
    php7.3-uuid \
    php7.3-xdebug \
    php7.3-yaml

RUN apt-get clean && apt-get dist-upgrade \
    && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf
COPY www.conf /usr/etc/php-fpm.d/www.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["/bin/bash", "-c", "/usr/local/etc/hosts.sh;php-fpm7.3 -F"]

EXPOSE 9000
