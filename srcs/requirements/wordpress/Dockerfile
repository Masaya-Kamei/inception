FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim openrc supervisor wget \
			nginx curl openssl \
			php8 php8-mbstring php8-gd \
			php8-iconv php8-fpm php8-mysqli php8-json php8-phar; \
		mkdir /var/log/supervisord; \
		rm -rf /var/cache/apk/*

WORKDIR /
RUN		openssl req -newkey rsa:4096 \
			-x509 \
			-sha256 \
			-days 3650 \
			-nodes \
			-out server.crt \
			-keyout server.key \
			-subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42Tokyo/OU=August/CN=example.com"

RUN     set -ex; \
		sed -i -e 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname; \
		echo 'rc_provide="loopback net"' >> /etc/rc.conf; \
        mkdir /run/openrc; \
        touch /run/openrc/softlevel; \
        rc-status

WORKDIR	/var/www/html/
RUN 	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
		chmod +x wp-cli.phar; \
		mv wp-cli.phar /usr/local/bin/wp
RUN		wp core download --locale=ja --path=/var/www/html/wordpress --version=6.0; \
		chown -R nginx:nginx /var/www/html/wordpress

COPY	./srcs/supervisord.conf /etc/
COPY	./srcs/entrypoint.sh /usr/bin/
COPY	./srcs/default.conf /etc/nginx/http.d/
COPY	./srcs/www.conf /etc/php8/php-fpm.d/
RUN		set -ex; \
		chmod +r /etc/supervisord.conf; \
		chmod +r /etc/nginx/http.d/default.conf; \
		chmod +r /etc/php8/php-fpm.d/www.conf; \
		chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT	["entrypoint.sh"]
