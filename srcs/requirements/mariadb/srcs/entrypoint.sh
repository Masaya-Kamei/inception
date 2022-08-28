#!/bin/ash

if [ -z "$(ls /var/lib/mysql)" ]; then
	/etc/init.d/mariadb setup
	rc-service mariadb start
    while [ `ps | grep "/usr/bin/mariadbd" | grep -v grep | wc -l` = 0 ]
    do
        sleep 0.1
    done
	mysql -u root <<- EOSQL
		CREATE DATABASE $DB_WP_NAME;
		CREATE USER '$DB_WP_USER_NAME'@'%' identified by '$DB_WP_USER_PASS';
		GRANT ALL PRIVILEGES ON $DB_WP_NAME.* TO '$DB_WP_USER_NAME'@'%';
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_USER_PASS';
		FLUSH PRIVILEGES;
	EOSQL
	rc-service mariadb stop
fi

supervisord -c /etc/supervisord.conf
