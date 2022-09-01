FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim supervisor vsftpd; \
		mkdir /var/log/supervisord; \
		rm -rf /var/cache/apk/*

RUN     set -ex; \
		# -D password を設定しない
        adduser ftpsuser -D; \
		# user_list :ログインできるユーザ、にftpsuserを追加
        echo ftpsuser > /etc/vsftpd.user_list; \
		# chroot_list :ホームディレクトリより上層へアクセスできるユーザ
        touch /etc/vsftpd.chroot_list; \
        # echo ftpsuser > /etc/vsftpd.chroot_list; \
        mkdir /etc/vsftpd/user_conf; \
		# ftpsuserのログイン後のディレクトリを指定
		# local_root のディレクトリの所有者がftpsuserの場合、以下のエラーが発生
		# ls: 致命的エラー: SSL_read: wrong version number
		# 所有者がftpsuser 以外の場合put やget を実行すると、以下のエラーが発生
		# put: Access failed: 553 Could not create file. (setup.sh)
		# つまりftpsuserでログインした後、ftpsuserディレクトリに移動して作業する*
        echo local_root=/var/www/html/wordpress > /etc/vsftpd/user_conf/ftpsuser

COPY	./tools/supervisord.conf /etc/
COPY	./tools/entrypoint.sh /usr/bin/
COPY	./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN		set -ex; \
		chmod +r /etc/supervisord.conf; \
		chmod +x /usr/bin/entrypoint.sh; \
		chmod +r /etc/vsftpd/vsftpd.conf

ENTRYPOINT	["entrypoint.sh"]
