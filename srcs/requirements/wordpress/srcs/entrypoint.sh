#!/bin/ash

cd /var/www/html
mkdir -p wordpress

if [ -z "$(ls /var/www/html/wordpress)" ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar;
	mv wp-cli.phar /usr/local/bin/wp;
	wp core download --locale=ja --path=/var/www/html/wordpress --version=6.0

	cd wordpress
	wp config create --skip-check \
		  --dbname=dbname \
		  --dbuser=dbuser \
		  --dbpass=dbpass \
		  --dbhost=mariadb;
    wp core install \
	  --url=https://localhost \
	  --title=title \
	  --admin_user=supervisor \
	  --admin_password=strongpassword \
	  --admin_email=info@example.com;
fi

supervisord -c /etc/supervisord.conf
