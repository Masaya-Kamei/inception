FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim vsftpd; \
		rm -rf /var/cache/apk/*

RUN     set -ex; \
        adduser testuser -D; \
        echo testuser > /etc/vsftpd.user_list; \
        touch /etc/vsftpd.chroot_list; \
        mkdir /etc/vsftpd/user_conf; \
        echo local_root=/var/www/html/wordpress > /etc/vsftpd/user_conf/testuser

COPY	./tools/entrypoint.sh /usr/bin/
COPY	./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN		set -ex; \
		chmod +x /usr/bin/entrypoint.sh; \
		chmod +r /etc/vsftpd/vsftpd.conf

ENTRYPOINT	["entrypoint.sh"]
