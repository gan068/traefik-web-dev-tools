# Traefik Web Development Environment Tools

- [Traefik Web Development Environment Tools](#traefik-web-development-environment-tools)
  - [Tool Description](#tool-description)
  - [Environment Preparation](#environment-preparation)
  - [Enable Reverse Proxy Traefik](#enable-reverse-proxy-traefik)
  - [View Traefik Dashboard](#view-traefik-dashboard)
  - [Connect to Redis](#connect-to-redis)
    - [redis .env Default Connection](#redis-env-default-connection)
    - [redis Client Default Connection](#redis-client-default-connection)
  - [Connect to mysql5.7](#connect-to-mysql57)
    - [mysql57 .env Default Connection](#mysql57-env-default-connection)
    - [mysql57 Client Default Connection](#mysql57-client-default-connection)
  - [Connect to mysql8](#connect-to-mysql8)
    - [mysql8 .env Default Connection](#mysql8-env-default-connection)
    - [mysql8 Client Default Connection](#mysql8-client-default-connection)
  - [PHP New Service Template](#php-new-service-template)
  - [Local Service Interconnection](#local-service-interconnection)
  - [Usage Examples](#usage-examples)
    - [php74](#php74)
      - [Modify Example php74 env](#modify-example-php74-env)
      - [Start php74 Example Service](#start-php74-example-service)
      - [Stop php74 Example Service](#stop-php74-example-service)
    - [php83](#php83)
      - [Modify Example php83 env](#modify-example-php83-env)
      - [Start php83 Example Service](#start-php83-example-service)
      - [Stop php83 Example Service](#stop-php83-example-service)
    - [laravel12](#laravel12)
      - [Modify Example laravel12 env](#modify-example-laravel12-env)
      - [Start laravel12 Example Service](#start-laravel12-example-service)
      - [Stop laravel12 Example Service](#stop-laravel12-example-service)
  - [Template Usage Example](#template-usage-example)
    - [Start Service](#start-service)
    - [Stop Service](#stop-service)
  - [License](#license)

## Tool Description

The tool uses Traefik as a web reverse proxy, allowing services to auto-register and take effect without repeatedly modifying proxy settings, increasing flexibility for maintenance.

## Environment Preparation

- Install Docker and ensure it's running after reboot
- Install make
- Create development environment network

```shell
docker network create dev-net
```

- Download the tool

```shell
git clone git@github.com:gan068/traefik-web-dev-tools.git
```

- Copy the service configuration

The `.env` content can be modified as needed.

```shell
cp .env.example .env
```

## Enable Reverse Proxy Traefik

```shell
# start
make web-up

# watch logs
make web-logs

# stop
make web-down
```

## View Traefik Dashboard

http://localhost:8080

(Default TRAEFIK_DASHBOARD_PORT=8080)

## Connect to Redis

```shell
# start
make redis-up

# watch logs
make redis-logs

# stop
make redis-down
```

### redis .env Default Connection

REDIS_HOST=redis  
REDIS_PORT=6379

### redis Client Default Connection

host: 127.0.0.1  
port: 6380

## Connect to mysql5.7

```shell
# start
make mysql57-up

# watch logs
make mysql57-logs

# stop
make mysql57-down
```

### mysql57 .env Default Connection

DB_HOST=mysql57  
DB_USERNAME=root  
DB_PASSWORD=root  
DB_PORT=3306

### mysql57 Client Default Connection

host: 127.0.0.1  
user: root  
password: root  
port: 3307

## Connect to mysql8

```shell
# start
make mysql8-up

# watch logs
make mysql8-logs

# stop
make mysql8-down
```

### mysql8 .env Default Connection

DB_HOST=mysql8  
DB_USERNAME=root  
DB_PASSWORD=root  
DB_PORT=3306

### mysql8 Client Default Connection

host: 127.0.0.1  
user: root  
password: root  
port: 3308

## PHP New Service Template

- templates/docker-compose.yml  
- templates/cicd/local/nginx/default.conf.template

New services use `APP_NAME` in `.env` as the URL  
Template: http://${APP_NAME}.localhost

Example: APP_NAME=www  
URL: http://www.localhost

## Local Service Interconnection

Local web (APP_NAME=web)  
http://web.localhost

Connect to local api (APP_NAME=api)  
http://api.localhost

Inside web, access the api URL as http://api-nginx  
If APP_NAME changes, the URL and internal URL will also change accordingly.

## Usage Examples

The tool provides a few sample projects:

### php74

#### Modify Example php74 env

```shell
cd php74
cp .env.example .env
```

#### Start php74 Example Service

```shell
cd php74
docker compose up -d
```

Accessible via browser:  
[http://php74.localhost](http://php74.localhost)

#### Stop php74 Example Service

```shell
cd php74
docker compose down
```

### php83

#### Modify Example php83 env

```shell
cd php83
cp .env.example .env
```

#### Start php83 Example Service

```shell
cd php83
docker compose up -d
```

Accessible via browser:  
[http://php83.localhost](http://php83.localhost)

#### Stop php83 Example Service

```shell
cd php83
docker compose down
```

### laravel12

#### Modify Example laravel12 env

```shell
cd laravel12
cp .env.example .env
```

#### Start laravel12 Example Service

```shell
cd laravel12
composer install
nvm use 22
npm install
docker compose up -d
```

Accessible via browser:  
[http://laravel12.localhost](http://laravel12.localhost)

#### Stop laravel12 Example Service

```shell
cd laravel12
docker compose down
```

## Template Usage Example

- Assume the new project is `code-igniter3`
- Copy templates
- Modify `code-igniter3/.env` APP_NAME to `ci3`

```shell
export TARGET_HOST=code-igniter3
cp ./templates/docker-compose.yml ${TARGET_HOST}/docker-compose.yml
cp ./templates/Dockerfile ${TARGET_HOST}/Dockerfile
cp ./templates/entrypoint.sh ${TARGET_HOST}/entrypoint.sh
cp ./templates/.env.example ${TARGET_HOST}/.env.example
cp ${TARGET_HOST}/.env.example ${TARGET_HOST}/.env
mkdir -p ${TARGET_HOST}/cicd/local/nginx && cp ./templates/cicd/local/nginx/default.conf.template ${TARGET_HOST}/cicd/local/nginx/default.conf.template
```

### Start Service

```shell
export TARGET_HOST=code-igniter3
cd ${TARGET_HOST}/public
composer install
cd ../
docker compose up -d

# force rebuild docker image (optional)
docker compose up -d --build
```

- Browse [http://ci3.localhost](http://ci3.localhost) to verify service is running

### Stop Service

```shell
export TARGET_HOST=code-igniter3
cd ${TARGET_HOST}
docker compose down
```

## License

This project is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0).

You are free to:

- Share — copy and redistribute the material in any medium or format  
- Adapt — remix, transform, and build upon the material for any purpose, even commercially

Under the following terms:

- **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made.  
  You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

Original author: gan068

[View full license](https://creativecommons.org/licenses/by/4.0/)
