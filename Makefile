include srcs/.env

# Default target
all: start

# Start services
start:
	sudo $(MKDIR_CMD) $(HOST_DB_DIR)
	sudo $(MKDIR_CMD) $(HOST_WP_DIR)
	sudo docker compose -f $(COMPOSE_FILE) up --build -d

# Stop services
stop:
	sudo docker compose -f $(COMPOSE_FILE) stop

# Stop and remove containers
down:
	sudo docker compose -f $(COMPOSE_FILE) down

# Clean unused containers
clean: down
	sudo docker container prune --force

# Full clean: remove volumes, images, and host data
fclean: clean
	sudo $(REMOVE_CMD) $(HOST_DB_DIR)
	sudo $(REMOVE_CMD) $(HOST_WP_DIR)
	sudo docker system prune --all --force
	-@docker volume inspect $(DOCKER_DB_VOLUME) >/dev/null 2>&1 && sudo docker volume rm $(DOCKER_DB_VOLUME)
	-@docker volume inspect $(DOCKER_WP_VOLUME) >/dev/null 2>&1 && sudo docker volume rm $(DOCKER_WP_VOLUME)


# Rebuild everything
re: fclean all

# Declare phony targets
.PHONY:		all volume up down clean fclean re