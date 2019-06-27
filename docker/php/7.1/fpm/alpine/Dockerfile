FROM    php:7.1-fpm-alpine

LABEL   maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ARG     XDEBUG_VERSION=${XDEBUG_VERSION:-2.7.2}
ARG     PHPREDIS_VERSION=${PHPREDIS_VERSION:-4.3.0}
ARG     AMQP_VERSION=${AMQP_VERSION:-1.9.4}
ARG     SSH2_VERSION=${SSH2_VERSION:-1.1.2}

ENV     COMPOSER_ALLOW_SUPERUSER=1

RUN     apk add --no-cache \
            icu-dev freetype-dev libzip-dev libpng-dev libxml2-dev libedit-dev readline-dev \
            gettext-dev libxslt-dev libssh2-dev rabbitmq-c-dev libjpeg-turbo-dev \
            composer bash lsof npm supervisor \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-configure zip --with-libzip \
        && docker-php-ext-install \
            bcmath gd intl mbstring opcache readline gettext \
            calendar pdo_mysql mysqli soap xsl zip \
        && apk add --no-cache --virtual .build-deps ${PHPIZE_DEPS} \
        && yes '' | pecl install --onlyreqdeps igbinary \
            xdebug-${XDEBUG_VERSION} redis-${PHPREDIS_VERSION} \
            amqp-${AMQP_VERSION} ssh2-${SSH2_VERSION} \
        && docker-php-ext-enable xdebug igbinary redis amqp ssh2 \
        && sed -i -e 's/^zend_extension/\;zend_extension/g' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
        && apk del .build-deps \
        && rm -rf /var/cache/apk/* \
        && rm -rf /tmp/* \
        && addgroup -g 1000 -S app \
        && adduser -u 1000 -S app -G app -h /var/www/html -s /bin/bash \
        && echo 'export PS1="\w $ "' > /var/www/.bashrc \
        && mkdir -p /var/www/.config /var/www/.npm /sock /usr/local/var/log \
        && touch /usr/local/var/log/php-fpm.log \
        && chown -R app:app /var/www/html /var/www/.bashrc /var/www/.config \
            /var/www/.npm /usr/local/etc/php/conf.d /sock /usr/local/var/log/php-fpm.log \
        && ln -s /var/www/html/node_modules/grunt/bin/grunt /usr/bin/grunt \
        && printf '* *\t* * *\troot\t%s/usr/local/bin/php /var/www/html/update/cron.php\n' >> /etc/crontab \
        && printf '* *\t* * *\troot\t%s/usr/local/bin/php /var/www/html/bin/magento cron:run\n' >> /etc/crontab \
        && printf '* *\t* * *\troot\t%s/usr/local/bin/php /var/www/html/bin/magento setup:cron:run\n#\n' >> /etc/crontab

COPY    conf/php.ini /usr/local/etc/php/
COPY    conf/*.conf /usr/local/etc/

WORKDIR /var/www/html

CMD     ["supervisord", "-c", "/usr/local/etc/supervisor.conf"]