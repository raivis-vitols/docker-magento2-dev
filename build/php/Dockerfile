FROM php:8.2-fpm

RUN apt-get update && \
    apt-get install -y cron && \
    apt-get install -y git && \
    apt-get install -y nano && \
    apt-get install -y unzip && \
    apt-get install -y curl

# GD
RUN apt-get install -y zlib1g-dev && \
    apt-get install -y libpng-dev && \
    apt-get install -y libjpeg-dev && \
    apt-get install -y libwebp-dev && \
    apt-get install -y libfreetype6-dev && \
# INTL
    apt-get install -y libicu-dev && \
# ZIP
    apt-get install -y libzip-dev && \
# SOAP
    apt-get install -y libxml2-dev && \
# XSL
    apt-get install -y libxslt1-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg -with-webp && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install -j$(nproc) bcmath && \
    docker-php-ext-install -j$(nproc) intl && \
    docker-php-ext-install -j$(nproc) pdo_mysql && \
    docker-php-ext-install -j$(nproc) zip && \
    docker-php-ext-install -j$(nproc) soap && \
    docker-php-ext-install -j$(nproc) xsl && \
    docker-php-ext-install -j$(nproc) sockets

RUN pecl install apcu && \
    docker-php-ext-enable apcu && \
    docker-php-ext-enable opcache

COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./php.ini /usr/local/etc/php-fpm.d/php-fpm.ini
COPY --from=composer:2.2 /usr/bin/composer /usr/local/bin/composer

RUN useradd -m -u 1000 docker && \
    usermod -a -G www-data docker && \
    usermod -a -G root www-data && \
    usermod -a -G root docker

RUN mkdir /home/docker/.composer && \
    chown docker:root -hR /home/docker && \
    chmod -R 775 /home/docker/.composer
