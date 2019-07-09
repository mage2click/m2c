ARG     NGINX_VERSION=${NGINX_VERSION:-1.17}

FROM    nginx:${NGINX_VERSION}-alpine

LABEL   maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

COPY    conf/nginx.conf /etc/nginx/nginx.conf
COPY    conf/conf.d/default.conf /etc/nginx/conf.d/default.conf

RUN     addgroup -S -g 1000 app && \
        adduser -S -g 1000 -u 1000 -h /var/www -s /bin/ash app && \
        touch /var/run/nginx.pid && \
        mkdir -p /sock && \
    	chown -R app:app /sock /var/cache/nginx /var/run/nginx.pid \
    		/etc/nginx/nginx.conf /etc/nginx/conf.d

USER    app:app

WORKDIR /var/www/html