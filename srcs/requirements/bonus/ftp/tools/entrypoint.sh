#!/bin/ash

echo "testuser:$FTP_TEST_USER_PASS" | chpasswd

if [ ! -d /var/www/html/wordpress/upload ]; then
    mkdir -p /var/www/html/wordpress/upload
    chmod a+w /var/www/html/wordpress/upload    
fi

exec vsftpd /etc/vsftpd/vsftpd.conf
