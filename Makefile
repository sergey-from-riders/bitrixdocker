up: create_network docker-up
down: docker-down delete_network
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

create_network:
	docker network inspect "bitrixdocker" > /dev/null 2>&1 || docker network create --subnet 172.20.0.0/24 "bitrixdocker";

delete_network:
	! docker network inspect "bitrixdocker" > /dev/null 2>&1 || docker network rm "bitrixdocker";