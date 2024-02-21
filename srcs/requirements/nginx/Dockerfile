FROM nginx:latest

ARG NGINX_HOST_DOMAIN

ENV NGINX_HOST_DOMAIN ${NGINX_HOST_DOMAIN}

COPY conf/wordpress.conf /etc/nginx/conf.d/wordpress.conf

RUN rm -f /etc/nginx/conf.d/default.conf
