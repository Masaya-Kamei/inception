FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim openrc supervisor curl \
			php8 php8-mbstring php8-gd \
			php8-iconv php8-fpm php8-mysqli php8-json php8-phar; \
		mkdir /var/log/supervisord; \
		rm -rf /var/cache/apk/*

RUN     set -ex; \
		sed -i -e 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname; \
		echo 'rc_provide="loopback net"' >> /etc/rc.conf; \
        mkdir /run/openrc; \
        touch /run/openrc/softlevel; \
        rc-status

COPY	./srcs/supervisord.conf /etc/
COPY	./srcs/entrypoint.sh /usr/bin/
COPY	./srcs/www.conf /etc/php8/php-fpm.d/
RUN		set -ex; \
		chmod +r /etc/supervisord.conf; \
		chmod +r /etc/php8/php-fpm.d/www.conf; \
		chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT	["entrypoint.sh"]
