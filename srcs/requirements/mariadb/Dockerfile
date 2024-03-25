FROM alpine:3.18.6

RUN <<EOF
apk --no-cache add mariadb mariadb-client
/usr/bin/mariadb-install-db --user=mysql --datadir=/var/lib/mysql
mkdir -p /var/log/mysql
touch /var/log/mysql/error.log
chown -R mysql:mysql /var/log/mysql
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
EOF

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY ./tools/mariadb.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

