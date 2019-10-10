FROM    alpine:3.8

LABEL   maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ARG     PHP_VERSION=${PHP_VERSION:-"7.2.22-r0"}

ENV     COMPOSER_ALLOW_SUPERUSER=1

COPY    common/conf/php.ini /etc/php7/conf.d/
COPY    common/conf/php-fpm.conf /etc/php7/
COPY    common/conf/supervisor.conf /etc/
COPY    common/bin/* /usr/local/bin/

RUN     apk update && \
        apk add --no-cache \
            php7=${PHP_VERSION} \
            php7-bcmath=${PHP_VERSION} \
            php7-calendar=${PHP_VERSION} \
            php7-ctype=${PHP_VERSION} \
            php7-curl=${PHP_VERSION} \
            php7-dom=${PHP_VERSION} \
            php7-fpm=${PHP_VERSION} \
            php7-gd=${PHP_VERSION} \
            php7-iconv=${PHP_VERSION} \
            php7-intl=${PHP_VERSION} \
            php7-json=${PHP_VERSION} \
            php7-mbstring=${PHP_VERSION} \
            php7-mysqli=${PHP_VERSION} \
            php7-opcache=${PHP_VERSION} \
            php7-openssl=${PHP_VERSION} \
            php7-pdo_mysql=${PHP_VERSION} \
            php7-simplexml=${PHP_VERSION} \
            php7-soap=${PHP_VERSION} \
            php7-sockets=${PHP_VERSION} \
            php7-sodium=${PHP_VERSION} \
            php7-tokenizer=${PHP_VERSION} \
            php7-xml=${PHP_VERSION} \
            php7-xmlwriter=${PHP_VERSION} \
            php7-xsl=${PHP_VERSION} \
            php7-zip=${PHP_VERSION} \
            php7-amqp \
            php7-mcrypt \
            php7-redis \
            php7-ssh2 \
            composer \
            curl \
            bash \
            gzip \
            lsof \
            npm \
            supervisor && \
        \
        \
        set -ex && cd /tmp && \
        curl -O https://files.magerun.net/n98-magerun2.phar && \
        mv n98-magerun2.phar /usr/local/bin/ && \
        chmod +x /usr/local/bin/n98-magerun2.phar && \
        \
        \
        rm -rf /var/cache/apk/* && \
        rm -rf /tmp/* && \
        \
        \
        addgroup -g 1000 -S app && \
        adduser -u 1000 -S app -G app -h /var/www -s /bin/bash && \
        echo 'export PS1="\w $ "' > /var/www/.bashrc && \
        \
        \
        mkdir -p /var/www/html /var/www/.config /var/www/.npm /sock && \
        touch /var/spool/cron/crontabs/app && \
        chown -R app:app /var/www/html /var/www/.bashrc /var/www/.config \
            /var/www/.npm /etc/php7/conf.d /sock /var/log \
            /usr/local/bin/n98-magerun2.phar && \
        chmod +x /usr/local/bin/docker-host /usr/local/bin/docker-php-entrypoint && \
        \
        \
        ln -sf /var/www/html/node_modules/grunt/bin/grunt /usr/bin/grunt && \
        ln -sf /usr/local/bin/n98-magerun2.phar /usr/local/bin/n98-magerun2 && \
        ln -sf /usr/sbin/php-fpm7 /usr/sbin/php-fpm && \
        ln -sf /etc/init.d/php-fpm7 /etc/init.d/php-fpm

ENTRYPOINT ["docker-php-entrypoint"]

WORKDIR /var/www/html

CMD     docker-host; supervisord -c /etc/supervisor.conf