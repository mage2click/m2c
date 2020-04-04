FROM        nginx:1.17-alpine

LABEL       maintainer="Mage2click, Dmitry Shkoliar @shkoliar"

COPY        conf/default.conf /etc/nginx/conf.d/
COPY        conf/html/index.html /usr/share/nginx/html/
COPY        bin/docker-entrypoint /nginx

RUN         apk update && \
            apk add --no-cache \
                openssh && \
            \
            \
            rm -rf /var/cache/apk/* && \
            rm -rf /tmp/* && \
            \
            \
            chmod +x /nginx && \
            \
            \
            adduser -D -s /bin/ash user && \
            passwd -u user && \
            \
            \
            echo "" > /etc/motd && \
            echo "" >> /etc/ssh/sshd_config && \
            echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
            echo "PermitTTY no" >> /etc/ssh/sshd_config && \
            echo "ForceCommand /sbin/nologin" >> /etc/ssh/sshd_config && \
            echo "" >> /etc/ssh/sshd_config && \
            echo "Match User user" >> /etc/ssh/sshd_config && \
            echo "  AllowTcpForwarding yes" >> /etc/ssh/sshd_config && \
            echo "  PermitEmptyPasswords yes" >> /etc/ssh/sshd_config && \
            echo "  PermitTTY no" >> /etc/ssh/sshd_config && \
            echo "  ForceCommand /sbin/nologin" >> /etc/ssh/sshd_config && \
            ssh-keygen -A

ENTRYPOINT  /nginx