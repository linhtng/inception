FROM alpine:3.18.6

RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

EXPOSE 3306

COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf
COPY tools/mariadb.sh /tmp/mariadb.sh
RUN chmod +x /tmp/mariadb.sh

CMD ["sh",  "/tmp/mariadb.sh"] 