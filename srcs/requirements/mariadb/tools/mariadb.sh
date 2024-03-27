#!/bin/sh

if [ -z "${MYSQL_ROOT_PASSWORD}" ] ; then
    echo "Error: MYSQL_DATABASE is not set"
    exit 1
fi

if [ -z "${MYSQL_USER}" ] || [ -z "${MYSQL_PASSWORD}" ] ; then
    echo "Error:  MYSQL_USER/PW is not set"
    exit 1
fi

mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
touch /var/log/mysql/error.log

# Initialize MariaDB data directory and create system tables
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm >/dev/null

# Start MariaDB service in the background
echo "Starting MariaDB service"
mysqld --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock --pid-file=/run/mysqld/mysqld.pid &


# Wait for the server to start
echo "Waiting for MariaDB to start..."
until mysqladmin ping -h localhost --silent; do
    sleep 1
done

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; 
then
    echo "Creating database ${MYSQL_DATABASE}..."
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
fi

echo "Stopping MariaDB service"
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Start MariaDB service in the foreground
echo "Starting MariaDB service in the foreground"
exec mysqld_safe "--defaults-file=/etc/my.cnf.d/my.cnf"