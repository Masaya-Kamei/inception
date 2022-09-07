#!/bin/ash

if [ -z "$(ls /var/lib/mysql)" ]; then
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
	mariadbd-safe --user=mysql --datadir=/var/lib/mysql &
    while ! echo 'SELECT 1' | mysql -uroot &> /dev/null;
    do
        sleep 0.1
    done
	mariadb -u root <<- EOSQL
		CREATE DATABASE $DB_WP_NAME;
		CREATE USER '$DB_WP_USER_NAME'@'%' IDENTIFIED BY '$DB_WP_USER_PASS';
		GRANT ALL ON $DB_WP_NAME.* TO '$DB_WP_USER_NAME'@'%';
		CREATE USER '$DB_WP_USER_NAME'@'localhost' IDENTIFIED BY '$DB_WP_USER_PASS';
		GRANT ALL ON $DB_WP_NAME.* TO '$DB_WP_USER_NAME'@'localhost';
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_USER_PASS';
		FLUSH PRIVILEGES;
	EOSQL
	pkill mariadb
fi

exec mariadbd-safe --user=mysql --datadir=/var/lib/mysql
