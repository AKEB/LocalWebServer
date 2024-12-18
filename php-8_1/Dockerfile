FROM php:8.1

ENV PATH="$PATH:/usr/local/bin"
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apt-get clean \
    && apt-get update -y --allow-insecure-repositories
RUN apt-get install -y --allow-unauthenticated \
    curl \
    ca-certificates apt-transport-https \
    wget dnsutils \
    libcurl4 \
    libcurl4-openssl-dev \
    git
RUN docker-php-ext-install curl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /app/
WORKDIR /app/

# CMD ["php"]
