FROM    php:7.1-fpm-alpine

LABEL   maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ARG     XDEBUG_VERSION=${XDEBUG_VERSION:-2.7.2}
ARG     PHPREDIS_VERSION=${PHPREDIS_VERSION:-4.3.0}
ARG     AMQP_VERSION=${AMQP_VERSION:-1.9.4}
ARG     SSH2_VERSION=${SSH2_VERSION:-1.1.2}

COPY    common/conf-xdebug/php.ini /usr/local/etc/php/
COPY    common/conf-xdebug/*.conf /usr/local/etc/
COPY    common/bin/docker-host /usr/local/bin/

RUN     apk add --no-cache busybox-suid \
            icu-dev freetype-dev libzip-dev libpng-dev libxml2-dev libedit-dev readline-dev \
            gettext-dev libxslt-dev libssh2-dev rabbitmq-c-dev libjpeg-turbo-dev libsodium-dev \
            libmcrypt-dev lsof supervisor && \
        docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
        docker-php-ext-configure zip --with-libzip && \
        docker-php-ext-install \
            bcmath gd intl mbstring opcache readline gettext \
            calendar pdo_mysql mysqli soap xsl zip && \
        apk add --no-cache --virtual .build-deps ${PHPIZE_DEPS} && \
        yes '' | pecl install --onlyreqdeps igbinary libsodium mcrypt-1.0.0 \
            xdebug-${XDEBUG_VERSION} redis-${PHPREDIS_VERSION} \
            amqp-${AMQP_VERSION} ssh2-${SSH2_VERSION} && \
        docker-php-ext-enable xdebug igbinary sodium mcrypt redis amqp ssh2 && \
        apk del .build-deps && \
        rm -rf /var/cache/apk/* && \
        rm -rf /tmp/* && \
        addgroup -g 1000 -S app && \
        adduser -u 1000 -S app -G app -h /var/www -s /bin/sh && \
        mkdir -p /var/www/.config /sock /usr/local/var/log /var/log && \
        touch /usr/local/var/log/php-fpm.log && \
        chown -R app:app /var/www/html /var/www/.config /usr/local/etc/php/conf.d \
            /sock /usr/local/var/log/php-fpm.log /var/log && \
        chmod +x /usr/local/bin/docker-host

WORKDIR /var/www/html

CMD     docker-host; supervisord -c /usr/local/etc/supervisor.conf