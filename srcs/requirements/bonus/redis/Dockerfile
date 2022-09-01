FROM	alpine:3.16.0

RUN		set -ex; \
		apk update; \
		apk add --no-cache \
			vim redis; \
		rm -rf /var/cache/apk/*

COPY	./tools/entrypoint.sh /usr/bin/
COPY	./conf/redis.conf /etc/
RUN		set -ex; \
		chmod +x /usr/bin/entrypoint.sh; \
		chmod +r /etc/redis.conf

ENTRYPOINT	["entrypoint.sh"]
