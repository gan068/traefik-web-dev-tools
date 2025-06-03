web-up:
	docker compose --env-file .env -f traefik/docker-compose.yml up -d
web-down:
	docker compose --env-file .env -f traefik/docker-compose.yml down
mysql57-up:
	docker compose --env-file .env -f mysql-5.7/docker-compose.yml up -d
mysql8-up:
	docker compose --env-file .env -f mysql-8/docker-compose.yml up -d
redis-up:
	docker compose --env-file .env -f redis/docker-compose.yml up -d
redis-down:
	docker compose --env-file .env -f redis/docker-compose.yml down
mysql57-down:
	docker compose --env-file .env -f mysql-5.7/docker-compose.yml down
mysql8-down:
	docker compose --env-file .env -f mysql-8/docker-compose.yml down
mysql57-logs:
	docker compose --env-file .env -f mysql-5.7/docker-compose.yml logs -f
mysql8-logs:
	docker compose --env-file .env -f mysql-8/docker-compose.yml logs -f
redis-logs:
	docker compose --env-file .env -f redis/docker-compose.yml logs -f
mysql57-exec:
	docker compose --env-file .env -f mysql-5.7/docker-compose.yml exec mysql57 bash
mysql8-exec:
	docker compose --env-file .env -f mysql-8/docker-compose.yml exec mysql8 bash
redis-exec:
	docker compose --env-file .env -f redis/docker-compose.yml exec redis bash
