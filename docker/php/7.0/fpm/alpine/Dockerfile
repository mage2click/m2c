FROM    php:7.0-fpm-alpine

LABEL   maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ARG     PHPREDIS_VERSION=${PHPREDIS_VERSION:-4.3.0}
ARG     AMQP_VERSION=${AMQP_VERSION:-1.9.4}
ARG     SSH2_VERSION=${SSH2_VERSION:-1.1.2}

ENV     COMPOSER_ALLOW_SUPERUSER=1

COPY    common/conf/php.ini /usr/local/etc/php/
COPY    common/conf/*.conf /usr/local/etc/
COPY    common/bin/docker-host /usr/local/bin/

RUN     apk add --no-cache busybox-suid \
            icu-dev freetype-dev libzip-dev libpng-dev libxml2-dev libedit-dev readline-dev \
            gettext-dev libxslt-dev libssh2-dev rabbitmq-c-dev libjpeg-turbo-dev libmcrypt-dev \
            bash lsof nodejs-npm supervisor && \
        docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
        docker-php-ext-configure zip --with-libzip && \
        docker-php-ext-install \
            bcmath gd intl mbstring opcache readline gettext \
            calendar mcrypt pdo_mysql mysqli soap xsl zip && \
        apk add --no-cache --virtual .build-deps ${PHPIZE_DEPS} && \
        yes '' | pecl install --onlyreqdeps igbinary \
            redis-${PHPREDIS_VERSION} amqp-${AMQP_VERSION} ssh2-${SSH2_VERSION} && \
        docker-php-ext-enable igbinary redis amqp ssh2 && \
        set -ex && cd /tmp && \
        curl -O https://files.magerun.net/n98-magerun2.phar && \
        mv n98-magerun2.phar /usr/local/bin/ && \
        chmod +x /usr/local/bin/n98-magerun2.phar && \
        apk del .build-deps && \
        curl -sS https://getcomposer.org/installer | \
            php -- --install-dir=/usr/local/bin --filename=composer && \
        rm -rf /var/cache/apk/* && \
        rm -rf /tmp/* && \
        addgroup -g 1000 -S app && \
        adduser -u 1000 -S app -G app -h /var/www -s /bin/bash && \
        echo 'export PS1="\w $ "' > /var/www/.bashrc && \
        mkdir -p /var/www/.config /var/www/.npm /sock /usr/local/var/log /var/log && \
        touch /usr/local/var/log/php-fpm.log /var/spool/cron/crontabs/app && \
        chown -R app:app /var/www/html /var/www/.bashrc /var/www/.config \
            /var/www/.npm /usr/local/etc/php/conf.d /sock /usr/local/var/log/php-fpm.log \
            /usr/local/bin/n98-magerun2.phar /var/log && \
        chmod +x /usr/local/bin/docker-host && \
        ln -sf /var/www/html/node_modules/grunt/bin/grunt /usr/bin/grunt && \
        ln -sf /usr/local/bin/n98-magerun2.phar /usr/local/bin/n98-magerun2

WORKDIR /var/www/html

CMD     docker-host; supervisord -c /usr/local/etc/supervisor.conf