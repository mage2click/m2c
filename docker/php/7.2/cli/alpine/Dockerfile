FROM    php:7.2-cli-alpine

LABEL   maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

RUN     apk add --no-cache \
            icu-dev freetype-dev libzip-dev libpng-dev libxml2-dev \
            libxslt-dev libssh2-dev libjpeg-turbo-dev lsof \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-configure zip --with-libzip \
        && docker-php-ext-install \
            bcmath gd intl mbstring opcache readline gettext \
            calendar pdo_mysql mysqli soap xsl zip \
        && rm -rf /var/cache/apk/* \
        && rm -rf /tmp/* \
        && addgroup -g 1000 -S app \
        && adduser -u 1000 -S app -G app -h /var/www/html -s /bin/bash \
        && echo 'export PS1="\w $ "' > /var/www/.bashrc \
        && chown -R app:app /var/www/html /var/www/.bashrc \
        && printf '* *\t* * *\tapp\t%s/usr/local/bin/php /var/www/html/update/cron.php\n' >> /etc/crontab \
        && printf '* *\t* * *\tapp\t%s/usr/local/bin/php /var/www/html/bin/magento cron:run\n' >> /etc/crontab \
        && printf '* *\t* * *\tapp\t%s/usr/local/bin/php /var/www/html/bin/magento setup:cron:run\n#\n' >> /etc/crontab

COPY    conf/php.ini /usr/local/etc/php/

USER    app:app

WORKDIR /var/www/html

CMD     ["cron", "-f", "-l", "8"]