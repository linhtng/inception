FROM alpine:3.18.6

RUN <<EOF
apk --no-cache add mariadb mariadb-client
/usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql
mkdir -p /var/log/mysql /run/mysqld
touch /var/log/mysql/error.log
chown -R mysql:mysql /var/log/mysql /run/mysqld
EOF


COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/mariadb.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

