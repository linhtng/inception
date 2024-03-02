FROM debian:bullseye

RUN apt-get update && apt-get upgrade && apt-get -y install wget \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client

RUN wget https://wordpress.org/wordpress-6.4.tar.gz -P /var/www \
    && cd /var/www && tar -xzf wordpress-6.4.tar.gz \
    && rm wordpress-6.4.tar.gz

RUN chown -R root:root /var/www/wordpress

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf