FROM php:7.2-fpm

ENV TZ=Europe/Moscow

WORKDIR /var/www

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
	librdkafka-dev

RUN PHP_OPENSSL=yes \
	&& pecl install imagick memcached msgpack rdkafka redis \
	&& docker-php-ext-enable imagick memcached msgpack rdkafka redis \
	&& pecl bundle -d /usr/src/php/ext/ igbinary \
	&& docker-php-ext-configure gd \
	--with-gd --with-webp-dir --with-jpeg-dir \
	--with-png-dir --with-zlib-dir --with-xpm-dir \
	--with-freetype-dir \
	&& docker-php-ext-install exif xml zip bcmath gd intl mysqli \
	pdo_mysql gettext pcntl sysvmsg sysvsem sysvshm xsl calendar shmop \
	sockets opcache igbinary 

RUN apt-get install -y  --allow-unauthenticated \
	mc iputils-ping curl ca-certificates wget

COPY hosts.sh /usr/local/etc/hosts.sh
RUN chmod +x /usr/local/etc/hosts.sh && /usr/local/etc/hosts.sh

COPY php-fpm.conf /usr/local/etc/php-fpm.conf
COPY www.conf /usr/local/etc/php-fpm.d/www.conf
COPY root_ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates -v
# CMD ["php-fpm"]
CMD ["/bin/bash", "-c", "/usr/local/etc/hosts.sh;php-fpm"]

EXPOSE 9000