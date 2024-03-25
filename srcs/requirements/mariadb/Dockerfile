FROM debian:bullseye

RUN apt-get update && apt-get upgrade && apt-get install mariadb-server mariadb-client -y \
    && rm -rf /var/lib/apt/lists/*

RUN <<EOF
/usr/bin/mariadb-install-db --user=mysql --datadir=/var/lib/mysql
mkdir -p /var/log/mysql
touch /var/log/mysql/error.log
chown -R mysql:mysql /var/log/mysql
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
EOF

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

COPY ./tools/mariadb.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]
