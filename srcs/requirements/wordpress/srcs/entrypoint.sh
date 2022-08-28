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
		  --dbname=$DB_WP_NAME \
		  --dbuser=$DB_WP_USER_NAME \
		  --dbpass=$DB_WP_USER_PASS \
		  --dbhost=$DB_HOST;
    wp core install \
	  --url=https://$DOMAIN_NAME \
	  --title=$WP_TITLE \
	  --admin_user=$WP_ADMIN_USER \
	  --admin_password=$WP_ADMIN_PASS \
	  --admin_email=$WP_ADMIN_EMAIL;
fi

supervisord -c /etc/supervisord.conf
