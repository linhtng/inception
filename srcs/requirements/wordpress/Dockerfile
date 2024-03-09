FROM alpine:3.18.6

RUN apk update && apk add --no-cache curl \
    php \
    php-fpm \
    php-mysqli \
    php-mbstring \
    php-phar \
    mariadb-client

# Install WP-CLI. Make the file executable and move it to /usr/local/bin/, so it can be run as just wp, instead of php wp-cli.phar
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy the custom configuration file to the container
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

# Create the directory to enable the php-fpm service to start
RUN mkdir /run/php && chmod 755 /run/php

COPY ./tools/init_wp.sh /usr/local/bin/init_wp.sh
RUN chmod +x /usr/local/bin/init_wp.sh

EXPOSE 9000

# Go to the html directory
WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/init_wp.sh"]