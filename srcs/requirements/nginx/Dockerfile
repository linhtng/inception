FROM debian:bullseye

RUN apt update && apt upgrade && apt install nginx openssl -y

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/CN=thuynguy.42.fr"

RUN mkdir -p /var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN echo "Hello, Nginx!" > /var/www/html/index.html  # Add this line

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]