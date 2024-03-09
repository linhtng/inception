#!/bin/sh

if [ -z "${MYSQL_ROOT_PASSWORD}" ] ; then
    echo "Error: MYSQL_DATABASE is not set"
    exit 1
fi

if [ -z "${MYSQL_USER}" ] || [ -z "${MYSQL_PASSWORD}" ] ; then
    echo "Error:  MYSQL_USER/PW is not set"
    exit 1
fi

# Initialize MariaDB data directory and create system tables
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm >/dev/null

# Start MariaDB service in the background
mysqld --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock --pid-file=/run/mysqld/mysqld.pid &

# service mysql start

# Wait for the server to start
until mysqladmin ping -h localhost --silent; do
    sleep 1
done

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; 
then
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
fi

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Start MariaDB service in the foreground
exec mysqld_safe