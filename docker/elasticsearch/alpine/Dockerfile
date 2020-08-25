FROM        alpine

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

ENV         PATH=/usr/share/elasticsearch/bin:${PATH} \
            ES_TMPDIR=/usr/share/elasticsearch/tmp \
            JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre

ARG         ELASTICSEARCH_VERSION=${ELASTICSEARCH_VERSION:-7.8.1}
ARG         ELASTICSEARCH_URL=${ELASTICSEARCH_URL:-'https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}-linux-x86_64.tar.gz'}

COPY        docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN         apk add --no-cache \
                openjdk8-jre su-exec bash && \
            apk add --no-cache -t .build-deps \
                wget ca-certificates gnupg openssl && \
            set -ex && cd /tmp && \
            wget --progress=bar:force -O elasticsearch.tar.gz \
                ${ELASTICSEARCH_URL//ELASTICSEARCH_VERSION/"${ELASTICSEARCH_VERSION}"} && \
            tar -xf elasticsearch.tar.gz && mv elasticsearch-${ELASTICSEARCH_VERSION/oss-/} \
                /usr/share/elasticsearch && \
            addgroup -g 1000 -S elasticsearch && \
            adduser -S -D -H -u 1000 -h /usr/share/elasticsearch -s /sbin/nologin -G elasticsearch \
                -g elasticsearch elasticsearch && \
            mkdir -p /usr/share/elasticsearch/{data,logs,config,plugins,tmp} \
                /usr/share/elasticsearch/config/scripts && \
            chown -R elasticsearch:elasticsearch /usr/share/elasticsearch \
                /usr/local/bin/docker-entrypoint.sh && \
            chmod +x /usr/local/bin/docker-entrypoint.sh && \
            cd /usr/share/elasticsearch && \
            bin/"$([[ "${ELASTICSEARCH_VERSION:0:1}" != "2" ]] && echo "elasticsearch-")"plugin install analysis-phonetic && \
            bin/"$([[ "${ELASTICSEARCH_VERSION:0:1}" != "2" ]] && echo "elasticsearch-")"plugin install analysis-icu && \
            apk del --purge .build-deps && \
            rm -rf /tmp/* /var/cache/apk/*

COPY        config/elasticsearch.yml config/log4j2.properties /usr/share/elasticsearch/config/

WORKDIR     /usr/share/elasticsearch

EXPOSE      9200 9300

ENTRYPOINT  ["/usr/local/bin/docker-entrypoint.sh"]

CMD         ["elasticsearch"]