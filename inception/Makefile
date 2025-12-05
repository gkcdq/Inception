.PHONY: all build up down clean

all: build up

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

clean: down
	rm -rf /home/tmilin/data/mariadb_data/*
	rm -rf /home/tmilin/data/wordpress_data/*
