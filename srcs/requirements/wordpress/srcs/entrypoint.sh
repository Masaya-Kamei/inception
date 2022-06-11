#!/bin/ash

cd /var/www/html/wordpress

if ! wp core is-installed; then
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

rc-service nginx start
supervisord -c /etc/supervisord.conf
