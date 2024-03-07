.PHONY: build up down

# Create directories for mounting volumes
prepare:
	mkdir -p srcs/home/thuynguy/data/wordpress
	mkdir -p srcs/home/thuynguy/data/mariadb

# Build the Docker images
build: prepare
	docker compose -f srcs/docker-compose.yml build

# Start the services
up:
	docker compose -f srcs/docker-compose.yml up -d

# Stop the services
down:
	docker compose -f srcs/docker-compose.yml down -v

fclean: down
	rm -rf srcs/home/thuynguy/data/wordpress
	rm -rf srcs/home/thuynguy/data/mariadb