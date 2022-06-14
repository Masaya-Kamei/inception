#!/bin/ash

if [ -z "$(ls /var/lib/mysql)" ]; then
	/etc/init.d/mariadb setup
	rc-service mariadb start
    while [ `ps | grep "/usr/bin/mariadbd" | grep -v grep | wc -l` = 0 ]
    do
        sleep 0.1
    done
	mysql -u root <<- EOSQL
		CREATE DATABASE dbname;
		CREATE USER 'dbuser'@'%' identified by 'dbpass';
		GRANT ALL PRIVILEGES ON dbname.* TO 'dbuser'@'%';
		ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
		FLUSH PRIVILEGES;
	EOSQL
	rc-service mariadb stop
fi

supervisord -c /etc/supervisord.conf
