#!/bin/sh

WAIT_INTERVAL=5

# Function to check if mariadb is up and running
check_mariadb() {
    mysql -u "$MYSQL_USER" -p "$MYSQL_PASSWORD" -h "$MYSQL_HOSTNAME" -e "SELECT 1;" >/dev/null 2>&1
}

until check_mariadb; do
    echo "Waiting for MariaDB to start..."
    sleep $WAIT_INTERVAL
done


if [ ! -f ./wp-config.php ]; 
then
    echo "Installing WordPress"
    wp core download --allow-root
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root
    wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root
    wp theme install twentytwentytwo --activate --allow-root
fi

# Start the PHP-FPM service in the foreground and leave it running constantly with -F
/usr/sbin/php-fpm7.4 -F;
