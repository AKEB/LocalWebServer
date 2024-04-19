FROM php:8.0-fpm

ENV TZ=Europe/Moscow

WORKDIR /var/www/html

USER root

RUN apt-get clean && apt-get dist-upgrade \
	&& apt-get update -y --allow-insecure-repositories

RUN apt-get install -y --allow-unauthenticated \
	libmagickwand-dev \
	libmagickcore-dev \
	libwebp-dev \
	libjpeg62-turbo-dev \
	libpng-dev libxpm-dev \
	libfreetype6-dev \
	libzip-dev \
	libz-dev \
	libmemcached-dev \
	libxslt-dev \
	zlib1g-dev \
	libssl-dev \
	librdkafka-dev \
	mc iputils-ping curl ca-certificates wget nano

RUN PHP_OPENSSL=yes \
	&& pecl install imagick memcached msgpack rdkafka redis \
	&& docker-php-ext-enable imagick memcached msgpack rdkafka redis \
	&& pecl bundle -d /usr/src/php/ext/ igbinary \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
	&& docker-php-ext-install exif xml filter zip bcmath gd intl mysqli \
	pdo_mysql gettext pcntl sysvmsg sysvsem sysvshm xsl ffi shmop \
	sockets opcache igbinary 

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh

COPY php-fpm.conf /usr/local/etc/php-fpm.conf
COPY www.conf /usr/local/etc/php-fpm.d/www.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# CMD ["php-fpm"]
CMD ["/bin/bash", "-c", "/usr/local/etc/hosts.sh;php-fpm"]

EXPOSE 9000