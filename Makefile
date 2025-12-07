# ============================================================================
# VARIABLES
# ============================================================================
DOCKER_COMPOSE := docker-compose
COMPOSE_FILE := srcs/docker-compose.yml
PROJECT_NAME := inception
VOLUME_NAME := wordpress_db
# Ajoutez d'autres volumes si nécessaire, séparés par un espace

# ============================================================================
# COMMANDES PRINCIPALES
# ============================================================================

# make all : Alias pour make up (démarrage complet)
all: up

# make up : Construit ou met à jour les images, puis démarre les conteneurs
# C'est la commande principale pour lancer le projet.
up: build
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d

# make build : Force la reconstruction des images (Nginx, MariaDB, etc.)
build:
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

# make down : Arrête et supprime les conteneurs et les réseaux
down:
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

# make restart : Redémarre l'ensemble des services
restart: down up

# ============================================================================
# COMMANDES DE DIAGNOSTIC ET GESTION
# ============================================================================

# make logs : Affiche les logs en temps réel (tail=100) pour le débug
logs:
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f --tail=100

# make ps : Affiche l'état des conteneurs (Up, Exited, Restart, etc.)
ps:
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) ps

# ============================================================================
# COMMANDES DE NETTOYAGE
# ============================================================================

# make stop : Arrête les conteneurs sans les supprimer
stop:
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) stop

# make fclean (Nettoyage Forcé/Complet) : Arrête tout, supprime les conteneurs, 
# les volumes (-v) et les images (-rmi all).
fclean: down
	sudo $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans

# make clean : Supprime le volume persistant de la base de données
# ATTENTION : Supprime toutes les données de la base de données !
clean:
	@echo "Suppression des volumes Docker..."
	sudo docker volume rm $(PROJECT_NAME)_$(VOLUME_NAME) || true

.PHONY: all up build down restart logs ps stop fclean clean