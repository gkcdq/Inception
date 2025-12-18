DOCKER_COMPOSE := docker-compose
COMPOSE_FILE := srcs/docker-compose.yml
PROJECT_NAME := inception
VOLUME_NAME := wordpress_db
# =====================
# COMMANDES PRINCIPALES
# =====================
all: up # make up : Construit ou met à jour les images, puis demarre les conteneurs, c'est la commande principale pour lancer le projet.
up: build
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d

# make build : Force la reconstruction des images (nginx, mariaDB et wordpresssss)
build:
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

# make down : Arrete et supprime les conteneurs et les réseaux
down:
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

# make restart : Redemarre l'ensemble des services
restart: down up

# make fclean (Nettoyage Force/Complet)  Arrete tout, supprime les conteneurs, 
# les volumes (-v) et les images (-rmi all).
fclean: down
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans

# make clean : Supprime les volumes persistant de la base de données
clean:
	@echo "Suppression des volumes Docker..."
	sudo docker volume rm $(PROJECT_NAME)_$(VOLUME_NAME) || true

.PHONY: all up build down restart logs ps stop fclean clean