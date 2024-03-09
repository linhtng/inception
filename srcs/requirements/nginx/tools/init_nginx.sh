#!/bin/sh

if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    echo "Creating self-signed SSL certificate...";
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/CN=thuynguy.42.fr"
    echo "Self-signed SSL certificate created.";
fi

exec "$@"
