FROM        php:7.1-fpm-alpine

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ENV         UID=1000
ENV         GID=1000

COPY        conf/php.ini /usr/local/etc/php/
COPY        conf/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/
COPY        bin/docker-entrypoint /php-fpm
COPY        bin/prompt /etc/profile.d/prompt.sh

RUN         apk update && \
            apk add --no-cache \
                curl \
                bash \
                busybox-suid \
                gnupg \
                gzip \
                openssh \
                lsof \
                icu-dev \
                freetype-dev \
                libzip-dev \
                libpng-dev \
                libxml2-dev \
                libedit-dev \
                readline-dev \
                gettext-dev \
                libxslt-dev \
                libssh2-dev \
                rabbitmq-c-dev \
                libjpeg-turbo-dev \
                libsodium-dev \
                libmcrypt-dev && \
            \
            \
            docker-php-ext-configure gd \
                --with-freetype-dir=/usr/include/ \
                --with-jpeg-dir=/usr/include/ && \
            docker-php-ext-configure zip \
                --with-libzip && \
            docker-php-ext-install \
                bcmath \
                calendar \
                dom \
                gd \
                gettext \
                iconv \
                intl \
                fileinfo \
                json \
                mbstring \
                opcache \
                pdo_mysql \
                simplexml \
                soap \
                sockets \
                tokenizer \
                xml \
                xmlwriter \
                xsl \
                zip && \
            \
            \
            apk add --no-cache --virtual \
                .build-deps ${PHPIZE_DEPS} && \
            \
            \
            pecl config-set php_ini \
                /usr/local/etc/php/php.ini && \
            yes '' | pecl install --onlyreqdeps \
                amqp-1.9.4 \
                igbinary \
                libsodium \
                mcrypt-1.0.0 \
                redis-4.3.0 \
                ssh2-1.1.2 \
                xdebug-2.7.2 && \
            \
            \
            docker-php-ext-enable \
                amqp \
                igbinary \
                mcrypt \
                redis \
                sodium \
                ssh2 \
                xdebug && \
            \
            \
            apk del \
                icu-dev \
                freetype-dev \
                libzip-dev \
                libpng-dev \
                libxml2-dev \
                libedit-dev \
                readline-dev \
                gettext-dev \
                libxslt-dev \
                libssh2-dev \
                rabbitmq-c-dev \
                libjpeg-turbo-dev \
                libsodium-dev \
                libmcrypt-dev \
                .build-deps && \
            \
            \
            apk add --no-cache \
                icu \
                freetype \
                libzip \
                libpng \
                libxml2 \
                libedit \
                readline \
                gettext \
                libxslt \
                libssh2 \
                rabbitmq-c \
                libjpeg-turbo \
                libsodium \
                libmcrypt \
            \
            \
            rm -rf /var/cache/apk/* && \
            rm -rf /tmp/* && \
            \
            \
            addgroup -g 1000 -S app && \
            adduser -u 1000 -S app -G app -h /var/www -s /bin/bash && \
            \
            \
            mkdir -p /var/www/html /var/www/.config /var/www/.npm /sock && \
            \
            \
            chmod +x /php-fpm

ENTRYPOINT  /php-fpm

WORKDIR     /var/www/html