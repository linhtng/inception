FROM alpine:3.18.6

RUN apk update && apk add --no-cache nginx openssl

RUN adduser -D -g 'www' www && \
	mkdir /www && chown -R www:www /var/lib/nginx && \
	chown -R www:www /www

RUN mkdir /etc/nginx/ssl && \
	sed -i 's/user nginx;/user www;/' /etc/nginx/nginx.conf

COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf
COPY ./tools/init_nginx.sh /var/www

RUN chmod +x /var/www/init_nginx.sh

ENTRYPOINT ["/var/www/init_nginx.sh"]

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]