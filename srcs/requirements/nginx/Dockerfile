FROM debian:bullseye

RUN apt-get update && apt-get upgrade && apt-get install nginx openssl -y

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/CN=thuynguy.42.fr"

RUN mkdir -p /var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/sites-available/default
COPY ./tools/init_nginx.sh /var/www

RUN chmod +x /var/www/init_nginx.sh

ENTRYPOINT ["/var/www/init_nginx.sh"]

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]