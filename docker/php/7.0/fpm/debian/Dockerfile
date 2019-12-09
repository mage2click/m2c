FROM        php:7.0-fpm

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ENV         PHP_EXTRA_CONFIGURE_ARGS="--enable-fpm --with-fpm-user=app --with-fpm-group=app --disable-cgi"
ENV         COMPOSER_ALLOW_SUPERUSER=1
ENV         UID=1000
ENV         GID=1000
ENV         NODE_VERSION=10

COPY        common/conf/php.ini /usr/local/etc/php/
COPY        common/conf/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/
COPY        common/bin/docker-entrypoint /php-fpm

RUN         curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash \
            && apt-get update \
            && apt-get install -y --no-install-recommends \
                bash \
                cron \
                git \
                gzip \
                inetutils-ping \
                iproute2 \
                lsof \
                nodejs \
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
            \
            \
            && curl -sS https://getcomposer.org/installer | php -- \
                --install-dir=/usr/local/bin --filename=composer \
            \
            \
            && curl -sS -o /usr/local/bin/n98-magerun https://files.magerun.net/n98-magerun2.phar \
            && chmod +x /usr/local/bin/n98-magerun \
            \
            \
            && chmod +x /php-fpm \
            && rm -rf /tmp/* \
            && rm -rf /var/lib/apt/lists/* \
            \
            \
            && groupadd -g 1000 app \
            && useradd -g 1000 -u 1000 -d /var/www -s /bin/bash app \
            && echo 'PS1="\w $ "' > /var/www/.bashrc \
            \
            \
            && npm install -g n grunt-cli

ENTRYPOINT  /php-fpm

WORKDIR     /var/www/html