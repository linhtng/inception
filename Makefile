.PHONY: build up down


# Build the Docker images
build: prepare
	docker compose -f srcs/docker-compose.yml build

down:
	docker compose -f srcs/docker-compose.yml down -v

# Start the services
up: build
	docker compose -f srcs/docker-compose.yml up -d

# Stop the services
clean:
	docker rm -vf $$(docker ps -aq)
	docker rmi -f $$(docker images -aq)

fclean: clean
	rm srcs/home/thuynguy/data/wordpress/*
	rm srcs/home/thuynguy/data/mariadb/*
