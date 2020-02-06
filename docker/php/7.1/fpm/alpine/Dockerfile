FROM        php:7.1-fpm-alpine

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ENV         COMPOSER_ALLOW_SUPERUSER=1
ENV         UID=1000
ENV         GID=1000
ENV         NODE_VERSION=10

COPY        conf/php.ini /usr/local/etc/php/
COPY        conf/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/
COPY        bin/docker-entrypoint /php-fpm
COPY        bin/prompt /etc/profile.d/prompt.sh

RUN         apk update && \
            apk add --no-cache \
                curl \
                bash \
                busybox-suid \
                git \
                gnupg \
                gzip \
                openssh \
                lsof \
                nodejs-npm \
                wget \
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
                ssh2-1.1.2 && \
            \
            \
            docker-php-ext-enable \
                amqp \
                igbinary \
                mcrypt \
                redis \
                sodium \
                ssh2 && \
            \
            \
            curl -sSL https://getcomposer.org/installer | php -- \
                --install-dir=/usr/local/bin --filename=composer && \
            \
            \
            curl -sSL -o /usr/local/bin/n98-magerun https://files.magerun.net/n98-magerun.phar && \
            chmod +x /usr/local/bin/n98-magerun && \
            \
            \
            curl -sSL -o /usr/local/bin/n98-magerun2 https://files.magerun.net/n98-magerun2.phar && \
            chmod +x /usr/local/bin/n98-magerun2 && \
            \
            \
            npm install -g n grunt-cli && \
            \
            \
            apk del .build-deps \
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