SRCSDIR	= ./srcs

all: up

up: setup
	docker-compose -f $(SRCSDIR)/docker-compose.yml up -d

down:
	docker-compose -f $(SRCSDIR)/docker-compose.yml down

build: setup
	docker-compose -f $(SRCSDIR)/docker-compose.yml up -d --build

build_no_cache: setup
	docker-compose -f $(SRCSDIR)/docker-compose.yml build --no-cache
	docker-compose -f $(SRCSDIR)/docker-compose.yml up -d

clean:
	- docker-compose -f $(SRCSDIR)/docker-compose.yml down
	- docker rmi nginx:inception mariadb:inception wordpress:inception redis:inception adminer:inception ftp:inception
	- docker volume rm wordpress mariadb adminer
	# - sudo mv /etc/hosts.bak /etc/hosts
	# - sudo rm -rf /home/mkamei

setup:
	# @if [ -z `cat /etc/hosts | grep mkamei` ]; then \
	# 	sudo cp /etc/hosts /etc/hosts.bak; \
	# 	sudo sh -c 'echo "127.0.0.1	mkamei.42.fr" >> /etc/hosts'; \
	# fi
	# @if [ ! -d /home/mkamei/data ]; then \
	# 	sudo mkdir -p /home/mkamei/data/mariadb; \
	# 	sudo mkdir -p /home/mkamei/data/wordpress; \
	# 	sudo mkdir -p /home/mkamei/data/adminer; \
	# fi

.PHONY		:	all up down build build_no_cache clean setup
