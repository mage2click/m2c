ARG         NGINX_VERSION=${NGINX_VERSION:-1.17}

FROM        nginx:${NGINX_VERSION}-alpine

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ENV         UID=1000
ENV         GID=1000

COPY        conf/nginx.conf /etc/nginx/nginx.conf
COPY        conf/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY        bin/docker-entrypoint /nginx

RUN         apk --no-cache add shadow && \
            addgroup -S -g 1000 app && \
            adduser -S -g 1000 -u 1000 -h /var/www -s /bin/ash app && \
            chmod +x /nginx

ENTRYPOINT  /nginx

WORKDIR     /var/www/html