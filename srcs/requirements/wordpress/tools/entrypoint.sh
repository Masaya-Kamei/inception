#!/bin/ash

cd /var/www/html

which wp
if [ $? -ne 0 ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar;
	mv wp-cli.phar /usr/local/bin/wp;
fi

wp core is-installed
if [ $? -ne 0 ]; then
	wp core download --locale=ja --path=/var/www/html/wordpress --version=6.0
	cd wordpress
	wp config create --skip-check \
		  --dbname=$DB_WP_NAME \
		  --dbuser=$DB_WP_USER_NAME \
		  --dbpass=$DB_WP_USER_PASS \
		  --dbhost=$DB_HOST \
		  --extra-php \
<<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
PHP
    wp core install \
	  --url=https://$DOMAIN_NAME \
	  --title=$WP_TITLE \
	  --admin_user=$WP_ADMIN_USER \
	  --admin_password=$WP_ADMIN_PASS \
	  --admin_email=$WP_ADMIN_EMAIL;
	wp user create \
    	$WP_AUTHOR_USER \
    	$WP_AUTHOR_EMAIL \
    	--role=author \
    	--user_pass=$WP_AUTHOR_PASS;
fi

cd /var/www/html/wordpress
wp plugin is-installed redis-cache
if [ $? -ne 0 ]; then
	wp plugin install redis-cache --activate
	cp wp-content/plugins/redis-cache/includes/object-cache.php wp-content/
fi

exec php-fpm8 -F
