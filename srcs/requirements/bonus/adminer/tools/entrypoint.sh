#!/bin/ash

mkdir -p /var/www/html/adminer

if [ ! -e /var/www/html/adminer/adminer.php ]; then
	cd /var/www/html/adminer
	wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php
	mv adminer-4.8.1.php adminer.php
fi

supervisord -c /etc/supervisord.conf
