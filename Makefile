SRCSDIR	= ./srcs

all:	up

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

.PHONY		:	all up down build
