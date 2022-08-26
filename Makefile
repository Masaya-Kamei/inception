SRCSDIR	= ./srcs

all: setup up

up:
	docker-compose -f $(SRCSDIR)/docker-compose.yml up -d

down:
	docker-compose -f $(SRCSDIR)/docker-compose.yml down

build:
	docker-compose -f $(SRCSDIR)/docker-compose.yml up -d --build

build_no_cache:
	docker-compose -f $(SRCSDIR)/docker-compose.yml build --no-cache
	docker-compose -f $(SRCSDIR)/docker-compose.yml up -d

clean:
	docker-compose -f $(SRCSDIR)/docker-compose.yml down
	docker rmi my_nginx my_mariadb my_wordpress
	docker volume rm wordpress mariadb
	sudo rm -rf /home/mkamei
	sudo mv /etc/hosts.bak /etc/hosts

setup:
	if [ -z "$(cat /etc/hosts | grep mkamei)" ]; then \
		sudo cp /etc/hosts /etc/hosts.bak; \
		sudo sh -c 'echo "127.0.0.1	mkamei.42.fr" >> /etc/hosts'; \
	fi
	sudo mkdir -p /home/mkamei/data/mariadb
	sudo mkdir -p /home/mkamei/data/wordpress

.PHONY		:	all up down build build_no_cache clean setup
