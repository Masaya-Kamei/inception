FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim supervisor curl \
			php8 php8-mbstring php8-gd \
			php8-iconv php8-fpm php8-mysqli php8-json php8-phar; \
		mkdir /var/log/supervisord; \
		rm -rf /var/cache/apk/*

COPY	./tools/supervisord.conf /etc/
COPY	./tools/entrypoint.sh /usr/bin/
COPY	./conf/www.conf /etc/php8/php-fpm.d/
RUN		set -ex; \
		chmod +r /etc/supervisord.conf; \
		chmod +x /usr/bin/entrypoint.sh; \
		chmod +r /etc/php8/php-fpm.d/www.conf

ENTRYPOINT	["entrypoint.sh"]
