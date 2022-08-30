FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim supervisor nginx openssl \
			php8 php8-mbstring php8-gd php8-session \
			php8-iconv php8-fpm php8-mysqli php8-json php8-phar; \
		mkdir /var/log/supervisord; \
		rm -rf /var/cache/apk/*

WORKDIR /etc/nginx
RUN		openssl req -newkey rsa:4096 -x509 -sha256 \
			-days 3650 -nodes -out server.crt -keyout server.key \
			-subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=August/CN=example.com"

COPY	./tools/supervisord.conf /etc/
COPY	./tools/entrypoint.sh /usr/bin/
COPY	./conf/www.conf /etc/php8/php-fpm.d/
COPY	./conf/default.conf /etc/nginx/http.d/
RUN		set -ex; \
		chmod +r /etc/supervisord.conf; \
		chmod +x /usr/bin/entrypoint.sh; \
		chmod +r /etc/php8/php-fpm.d/www.conf; \
		chmod +r /etc/nginx/http.d/default.conf

ENTRYPOINT	["entrypoint.sh"]
