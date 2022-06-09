FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim openrc supervisor wget \
			php8 php8-mbstring php8-gd \
			php8-iconv php8-fpm php8-mysqli php8-json php8-phar; \
		mkdir /var/log/supervisord; \
		rm -rf /var/cache/apk/*

RUN     set -ex; \
        sed -i -e '275 s/cgroup_add_service/#cgroup_add_service/' /lib/rc/sh/openrc-run.sh; \
        mkdir /run/openrc; \
        touch /run/openrc/softlevel; \
        rc-status

WORKDIR	/var/www/html/
RUN		set -ex; \
		wget https://ja.wordpress.org/wordpress-5.6.1-ja.tar.gz; \
		tar -xvzf wordpress-5.6.1-ja.tar.gz; \
		rm wordpress-5.6.1-ja.tar.gz;
		# chown -R nginx:nginx /var/www/html/wordpress

COPY	./srcs/supervisord.conf /etc/
COPY	./srcs/entrypoint.sh /usr/bin/
RUN		set -ex; \
		chmod +r /etc/supervisord.conf; \
		chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT	["entrypoint.sh"]
