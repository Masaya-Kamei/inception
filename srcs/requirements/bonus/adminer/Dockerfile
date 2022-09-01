FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim php8 php8-mbstring php8-gd php8-session \
			php8-iconv php8-fpm php8-mysqli php8-json php8-phar; \
		rm -rf /var/cache/apk/*

COPY	./tools/entrypoint.sh /usr/bin/
COPY	./conf/www.conf /etc/php8/php-fpm.d/
RUN		set -ex; \
		chmod +x /usr/bin/entrypoint.sh; \
		chmod +r /etc/php8/php-fpm.d/www.conf

ENTRYPOINT	["entrypoint.sh"]
