FROM        php:7.0-fpm

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ENV         PHP_EXTRA_CONFIGURE_ARGS="--enable-fpm --with-fpm-user=app --with-fpm-group=app --disable-cgi"
ENV         COMPOSER_ALLOW_SUPERUSER=1
ENV         UID=1000
ENV         GID=1000

COPY        common/conf-xdebug/php.ini /usr/local/etc/php/
COPY        common/conf-xdebug/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/
COPY        common/bin/docker-entrypoint-xdebug /php-fpm

RUN         apt-get update && apt-get install -y --no-install-recommends \
                bash \
                gzip \
                inetutils-ping \
                iproute2 \
                lsof \
                wget \
                libfreetype6-dev \
                libjpeg62-turbo-dev \
                libmcrypt-dev \
                libpng-dev \
                librabbitmq-dev \
                libssh2-1-dev \
                libxslt-dev \
                libzip-dev \
            \
            \
            && docker-php-ext-configure \
                gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
            && docker-php-ext-configure \
                gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
            && docker-php-ext-configure \
                zip --with-libzip \
            \
            \
            && docker-php-ext-install -j$(nproc) \
                bcmath \
                gd \
                intl \
                mcrypt \
                opcache \
                pdo_mysql \
                soap \
                xsl \
                zip \
            \
            \
            && pecl install xdebug-2.8.0 \
            && pecl install igbinary-3.0.1 \
            && pecl install redis-5.1.0 \
            && pecl install amqp-1.9.4 \
            \
            \
            && wget https://pecl.php.net/get/ssh2 -O /tmp/ssh2-1.2.tgz \
            && pear install /tmp/ssh2-1.2.tgz \
            \
            \
            && docker-php-ext-enable \
                amqp \
                igbinary \
                redis \
                ssh2 \
                xdebug \
            \
            \
            && chmod +x /php-fpm \
            && rm -rf /tmp/* \
            && rm -rf /var/lib/apt/lists/* \
            \
            \
            && groupadd -g 1000 app \
            && useradd -g 1000 -u 1000 -d /var/www -s /bin/bash app \
            && echo 'PS1="\w $ "' > /var/www/.bashrc

ENTRYPOINT  /php-fpm

WORKDIR     /var/www/html