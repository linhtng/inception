FROM alpine:3.18.6

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

ENV PATH="/usr/sbin:${PATH}"

# RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 755 /var/run/mysqld

EXPOSE 3306

COPY ./tools/mariadb.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]
