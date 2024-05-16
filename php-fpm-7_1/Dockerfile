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
    php7.1-fpm php7.1-common \
    php7.1-bcmath \
    php7.1-curl \
    php7.1-dom \
    php7.1-gd \
    php7.1-igbinary \
    php7.1-imagick \
    php7.1-intl \
    php7.1-mbstring \
    php7.1-memcached \
    php7.1-msgpack \
    php7.1-mysqli \
    php7.1-mysqlnd \
    php7.1-sqlite3 \
    php7.1-zip \
    php7.1-redis \
    php7.1-rdkafka \
    php7.1-bz2 \
    # php7.1-cgi \
    # php7.1-cli \
    # php7.1-decimal \
    # php7.1-dev \
    # php7.1-raphf \
    # php7.1-http \
    # php7.1-ldap \
    # php7.1-mongodb \
    # php7.1-oauth \
    # php7.1-odbc \
    # php7.1-opcache \
    # php7.1-pgsql \
    # php7.1-smbclient \
    # php7.1-soap \
    # php7.1-ssh2 \
    # php7.1-uuid \
    php7.1-xdebug \
    php7.1-yaml

RUN apt-get clean && apt-get dist-upgrade \
    && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["/bin/bash", "-c", "/usr/local/etc/hosts.sh;php-fpm7.1 -F"]

EXPOSE 9000
