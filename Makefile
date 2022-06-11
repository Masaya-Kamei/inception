SRCSDIR	= ./srcs

all:	up

up:
	docker-compose -f $(SRCSDIR)/docker-compose.yml up -d

down:
	docker-compose -f $(SRCSDIR)/docker-compose.yml down

build:
	docker-compose -f $(SRCSDIR)/docker-compose.yml up -d --build

build_nc:
	docker-compose -f $(SRCSDIR)/docker-compose.yml build --no-cache
	docker-compose -f $(SRCSDIR)/docker-compose.yml up -d

.PHONY		:	all up down build
