FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim openrc supervisor redis; \
		mkdir /var/log/supervisord; \
		rm -rf /var/cache/apk/*

RUN     set -ex; \
		sed -i -e 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname; \
		echo 'rc_provide="loopback net"' >> /etc/rc.conf; \
        mkdir /run/openrc; \
        touch /run/openrc/softlevel; \
        rc-status

COPY	./tools/supervisord.conf /etc/
COPY	./tools/entrypoint.sh /usr/bin/
COPY	./conf/redis.conf /etc/
RUN		set -ex; \
		chmod +r /etc/supervisord.conf; \
		chmod +x /usr/bin/entrypoint.sh; \
		chmod +r /etc/redis.conf

ENTRYPOINT	["entrypoint.sh"]
