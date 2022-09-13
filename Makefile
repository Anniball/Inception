all:
	#Building all images
	docker-compose -f srcs/docker-compose.yml build
	#Creating folders for the external volumes (see docker-compose)
	mkdir -p /home/ldelmas/data
	mkdir -p /home/ldelmas/data/wordpress
	mkdir -p /home/ldelmas/data/database
	#Adding adresses refering to localhost
	chmod 777 /etc/hosts
	echo "127.0.0.1 ldelmas.42.fr" >> /etc/hosts
	echo "127.0.0.1 www.ldelmas.42.fr" >> /etc/hosts
	#Running every coontainers (will use detach to make them as background tasks)
	docker-compose -f srcs/docker-compose.yml up #--detach

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up --detach

down:
	docker-compose -f srcs/docker-compose.yml down

clean: 
	docker-compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans

fclean: down clean
	docker system prune -af --volumes
	rm -rf /home/ldelmas/data
	docker network prune -f
	echo docker volume rm $(docker volume ls -q)
	docker image prune -f

re: fclean all

.PHONY: all build up down clean fclean re