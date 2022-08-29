FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim openrc supervisor mariadb mariadb-client; \
		mkdir /var/log/supervisord; \
		rm -rf /var/cache/apk/*

RUN     set -ex; \
        mkdir /run/openrc; \
        touch /run/openrc/softlevel; \
        rc-status

COPY	./tools/supervisord.conf /etc/
COPY	./tools/entrypoint.sh /usr/bin/
COPY	./conf/mariadb-server.cnf /etc/my.cnf.d/
RUN		set -ex; \
		chmod +r /etc/supervisord.conf; \
		chmod +x /usr/bin/entrypoint.sh; \
		chmod +r /etc/my.cnf.d/mariadb-server.cnf

ENTRYPOINT	["entrypoint.sh"]
