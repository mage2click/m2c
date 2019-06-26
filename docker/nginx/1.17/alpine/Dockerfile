FROM    nginx:1.17-alpine

LABEL   maintainer="Mage2click"

COPY    conf/* /etc/nginx/

RUN     addgroup -S -g 1000 app && \
        adduser -S -g 1000 -u 1000 -h /var/www -s /bin/ash app && \
        touch /var/run/nginx.pid && \
        mkdir -p /sock && \
    	chown -R app:app /sock /var/cache/nginx /var/run/nginx.pid \
    		/etc/nginx/nginx.conf /etc/nginx/conf.d

USER    app:app

WORKDIR /var/www/html