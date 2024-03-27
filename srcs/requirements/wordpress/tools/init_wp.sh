#!/bin/sh

# First wait for mariadb to be accessible
while ! mysql -h ${MYSQL_HOSTNAME} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e ";" 2>/dev/null; do
    echo "Waiting for MariaDB to be accessible..."
    sleep 5
done

echo "MariaDB is accessible."

# Create the directory to enable the php-fpm service to start
mkdir -p /var/www/html /var/www/html/wordpress /run/php/
chown -R www:www /var/www/html/
cd /var/www/html;

if [ ! -f /var/www/html/wp-config.php ]; 
then
    echo "Installing WordPress"
    wp core download --allow-root
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root
    wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root
    wp theme install twentytwentythree --activate --allow-root
fi

# chown -R www:www /var/www/html/

# Start the PHP-FPM service in the foreground and leave it running constantly with -F
exec /usr/sbin/php-fpm81 -F;
