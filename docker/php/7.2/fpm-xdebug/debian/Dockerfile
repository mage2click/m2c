FROM        php:7.2-fpm

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ENV         UID=1000
ENV         GID=1000

COPY        conf/php.ini /usr/local/etc/php/
COPY        conf/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/
COPY        bin/docker-entrypoint /php-fpm
COPY        bin/prompt /etc/profile.d/prompt.sh

RUN         apt-get update && \
            apt-get install -y --no-install-recommends \
                bash \
                gzip \
                gnupg \
                inetutils-ping \
                iproute2 \
                lsof \
                wget \
                libfreetype6-dev \
                libjpeg62-turbo-dev \
                libmcrypt-dev \
                libpng-dev \
                librabbitmq-dev \
                libsodium-dev \
                libssh2-1-dev \
                libxslt-dev \
                libzip-dev && \
            \
            \
            docker-php-ext-configure \
                gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
            docker-php-ext-configure \
                gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
            docker-php-ext-configure \
                zip --with-libzip && \
            \
            \
            docker-php-ext-install -j$(nproc) \
                bcmath \
                calendar \
                dom \
                gd \
                gettext \
                iconv \
                intl \
                json \
                mbstring \
                opcache \
                pdo_mysql \
                simplexml \
                soap \
                sockets \
                sodium \
                tokenizer \
                xml \
                xmlwriter \
                xsl \
                zip && \
            \
            \
            pecl install xdebug-2.8.0 && \
            pecl install igbinary-3.0.1 && \
            pecl install mcrypt-1.0.3 && \
            pecl install redis-5.1.0 && \
            pecl install amqp-1.9.4 && \
            \
            \
            wget https://pecl.php.net/get/ssh2 -O /tmp/ssh2-1.2.tgz && \
            pear install /tmp/ssh2-1.2.tgz && \
            \
            \
            docker-php-ext-enable \
                amqp \
                igbinary \
                mcrypt \
                redis \
                ssh2 \
                xdebug && \
            \
            \
            curl -sSL -o /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
            chmod +x /usr/local/bin/mhsendmail && \
            \
            \
            rm -rf /tmp/* && \
            rm -rf /var/lib/apt/lists/* && \
            \
            \
            groupadd -g 1000 app && \
            useradd -g 1000 -u 1000 -d /var/www -s /bin/bash app && \
            \
            \
            chmod +x /php-fpm

ENTRYPOINT  /php-fpm

WORKDIR     /var/www/html