FROM debian:12.5-slim

ENV TZ=Europe/Moscow

WORKDIR /var/www/html

USER root

RUN apt-get clean && apt-get dist-upgrade -y \
	&& apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
  iputils-ping curl \
  ca-certificates apt-transport-https software-properties-common lsb-release \
  wget nano git sqlite3

RUN curl -sSL https://packages.sury.org/php/README.txt | bash -x

RUN apt-get clean && apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
    php8.3-fpm php8.3-common \
    php8.3-bcmath \
    php8.3-curl \
    php8.3-dom \
    php8.3-gd \
    php8.3-igbinary \
    php8.3-imagick \
    php8.3-intl \
    php8.3-mbstring \
    php8.3-memcached \
    php8.3-msgpack \
    php8.3-mysqli \
    php8.3-mysqlnd \
    php8.3-sqlite3 \
    php8.3-zip \
    php8.3-redis \
    php8.3-rdkafka \
    php8.3-bz2 \
    # php8.3-cgi \
    # php8.3-cli \
    # php8.3-decimal \
    # php8.3-dev \
    # php8.3-raphf \
    # php8.3-http \
    # php8.3-ldap \
    # php8.3-mongodb \
    # php8.3-oauth \
    # php8.3-odbc \
    # php8.3-opcache \
    # php8.3-pgsql \
    # php8.3-protobuf \
    # php8.3-smbclient \
    # php8.3-soap \
    # php8.3-ssh2 \
    # php8.3-uuid \
    php8.3-xdebug \
    php8.3-yaml

RUN apt-get clean && apt-get dist-upgrade -y \
    && apt-get update -y --allow-insecure-repositories

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh

RUN touch /run_on_start.sh && chmod +x /run_on_start.sh

RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/8.3/fpm/php-fpm.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["/bin/bash", "-c", "/usr/local/etc/hosts.sh;/run_on_start.sh;php-fpm8.3 -F"]

EXPOSE 9000
