up: docker-up
down: docker-down
restart: docker-down docker-up
build: docker-build
pull: docker-pull
docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build