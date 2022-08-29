FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim openrc supervisor nginx openssl; \
		mkdir /var/log/supervisord; \
		rm -rf /var/cache/apk/*

RUN     set -ex; \
		sed -i -e 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname; \
		echo 'rc_provide="loopback net"' >> /etc/rc.conf; \
        mkdir /run/openrc; \
        touch /run/openrc/softlevel; \
        rc-status

WORKDIR /etc/nginx
RUN		openssl req -newkey rsa:4096 -x509 -sha256 \
			-days 3650 -nodes -out server.crt -keyout server.key \
			-subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=August/CN=example.com"

COPY	./tools/supervisord.conf /etc/
COPY	./tools/entrypoint.sh /usr/bin/
COPY	./conf/default.conf /etc/nginx/http.d/
RUN		set -ex; \
		chmod +r /etc/supervisord.conf; \
		chmod +x /usr/bin/entrypoint.sh; \
		chmod +r /etc/nginx/http.d/default.conf

ENTRYPOINT	["entrypoint.sh"]
