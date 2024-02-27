FROM debian:buster

RUN apt install nginx -y

RUN apt install vim -y

RUN apt install curl -y

RUN mkdir -p /etc/nginx/ssl

RUN apt install OpenSSL -y

ARG SSL_PATH=/etc/nginx/ssh/inception
RUN openssl req -x509 -nodes -out ${SSL_PATH}.crt -keyout ${SSL_PATH}.key \
	-subj "/CN=${SSL_PATH}"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
