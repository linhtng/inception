.PHONY: build up down

# Create directories for mounting volumes
prepare:
	mkdir -p srcs/home/thuynguy/data/wordpress


# Build the Docker images
build: prepare
	docker compose -f srcs/docker-compose.yml build

# Start the services
up: build
	docker compose -f srcs/docker-compose.yml up -d

# Stop the services
clean:
	docker rm -vf $$(docker ps -aq)
	docker rmi -f $$(docker images -aq)

fclean: clean
	rm -rf srcs/home/thuynguy/data/wordpress
