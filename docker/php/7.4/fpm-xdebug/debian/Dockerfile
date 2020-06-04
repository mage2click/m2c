FROM        php:7.4-fpm

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ENV         UID=1000
ENV         GID=1000

COPY        --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin

COPY        conf/php.ini /usr/local/etc/php/
COPY        conf/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/
COPY        bin/docker-entrypoint /php-fpm
COPY        bin/prompt /etc/profile.d/prompt.sh

RUN         install-php-extensions \
                amqp \
                bcmath \
                calendar \
                gd \
                gettext \
                igbinary \
                intl \
                mcrypt \
                mysqli \
                opcache \
                pdo_mysql \
                redis \
                soap \
                sockets \
                ssh2 \
                xdebug \
                xsl \
                zip && \
            \
            \
            apt-get update && \
            apt-get install -y --no-install-recommends \
                gnupg \
                gzip \
                htop \
                inetutils-ping \
                iproute2 \
                lsof \
                ssh \
                unzip \
                wget \
                zip && \
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
            mkdir -p /var/www/html /var/www/.config /var/www/.npm /sock && \
            \
            \
            chmod +x /php-fpm

ENTRYPOINT  /php-fpm

WORKDIR     /var/www/html