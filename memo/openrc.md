# RUN     set -ex; \
# 		sed -i -e 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname; \
# 		echo 'rc_provide="loopback net"' >> /etc/rc.conf; \
#         mkdir /run/openrc; \
#         touch /run/openrc/softlevel; \
#         rc-status