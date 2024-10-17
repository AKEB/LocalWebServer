FROM debian:12.5-slim

ENV TZ=Europe/Moscow

WORKDIR /var/www/html

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
    php7.2-fpm php7.2-common \
    php7.2-bcmath \
    php7.2-curl \
    php7.2-dom \
    php7.2-gd \
    php7.2-igbinary \
    php7.2-imagick \
    php7.2-intl \
    php7.2-mbstring \
    php7.2-memcached \
    php7.2-msgpack \
    php7.2-mysqli \
    php7.2-mysqlnd \
    php7.2-sqlite3 \
    php7.2-zip \
    php7.2-redis \
    php7.2-rdkafka \
    php7.2-bz2 \
    # php7.2-cgi \
    # php7.2-cli \
    # php7.2-decimal \
    # php7.2-dev \
    # php7.2-raphf \
    # php7.2-http \
    # php7.2-ldap \
    # php7.2-mongodb \
    # php7.2-oauth \
    # php7.2-odbc \
    # php7.2-opcache \
    # php7.2-pgsql \
    # php7.2-smbclient \
    # php7.2-soap \
    # php7.2-ssh2 \
    # php7.2-uuid \
    php7.2-xdebug \
    php7.2-yaml

RUN apt-get clean && apt-get dist-upgrade -y \
    && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh
RUN touch /run_on_start.sh && chmod +x /run_on_start.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["/bin/bash", "-c", "/usr/local/etc/hosts.sh;/run_on_start.sh;php-fpm7.2 -F"]

EXPOSE 9000
