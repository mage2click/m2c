FROM        php:5.6-fpm

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ENV         COMPOSER_ALLOW_SUPERUSER=1
ENV         UID=1000
ENV         GID=1000
ENV         NODE_VERSION=10

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
                xsl \
                zip && \
            \
            \
            curl -sSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash && \
            apt-get update && \
            apt-get install -y --no-install-recommends \
                cron \
                git \
                gnupg \
                gzip \
                htop \
                inetutils-ping \
                iproute2 \
                lsof \
                nodejs \
                ssh \
                sudo \
                unzip \
                wget \
                zip && \
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
            curl -sSL -o /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
            chmod +x /usr/local/bin/mhsendmail && \
            \
            \
            npm install -g n grunt-cli && \
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
            echo "app ALL=NOPASSWD: ALL" >> /etc/sudoers && \
            \
            \
            mkdir -p /var/www/html /var/www/.config /var/www/.npm /sock && \
            \
            \
            chmod +x /php-fpm

ENTRYPOINT  /php-fpm

WORKDIR     /var/www/html