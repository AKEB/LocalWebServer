FROM debian:12.5-slim

ARG PHP_VERSION="8.3"
ENV PHP_VERSION=${PHP_VERSION}
ENV TZ=UTC
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

USER root

# Base system setup
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates curl wget gnupg2 && \
    rm -rf /var/lib/apt/lists/*

# Install basic tools (without software-properties-common)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        iputils-ping curl \
        apt-transport-https lsb-release \
        nano git sqlite3 iproute2 dnsutils && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Add Sury PHP repository (ARM-compatible method)
RUN curl -sSLo /usr/share/keyrings/sury-php-archive-keyring.gpg \
    https://packages.sury.org/php/apt.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/sury-php-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" \
    > /etc/apt/sources.list.d/sury-php.list

# Install PHP and extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
        php${PHP_VERSION}-yaml && \
    rm -rf /var/lib/apt/lists/*

# Optional: Install Xdebug separately if needed
RUN apt-get update && \
    apt-get install -y php${PHP_VERSION}-xdebug && \
    rm -rf /var/lib/apt/lists/*

# Configure PHP
RUN mkdir -p /usr/etc/php-fpm.d/
COPY php-fpm.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
COPY 00-env.ini /etc/php/${PHP_VERSION}/fpm/conf.d/00-env.ini
COPY 00-env.ini /etc/php/${PHP_VERSION}/cli/conf.d/00-env.ini

# SSL certificates
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

# Install Composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer

# Final setup
RUN touch /run_on_start.sh && chmod +x /run_on_start.sh

CMD ["/bin/bash", "-c", "/run_on_start.sh; php-fpm${PHP_VERSION} -F"]

EXPOSE 9000
