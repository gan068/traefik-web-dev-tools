# Traefik 網站開發環境工具

- [Traefik 網站開發環境工具](#traefik-網站開發環境工具)
  - [工具說明](#工具說明)
  - [環境準備](#環境準備)
  - [啟用反向代理 Traefik](#啟用反向代理-traefik)
  - [查看 Traefik Dashboard](#查看-traefik-dashboard)
  - [連線 redis](#連線-redis)
    - [redis .env 預設連線](#redis-env-預設連線)
    - [redis client 預設連線](#redis-client-預設連線)
  - [連線 mysql5.7](#連線-mysql57)
    - [mysql57 .env 預設連線](#mysql57-env-預設連線)
    - [mysql57 client 預設連線](#mysql57-client-預設連線)
  - [連線 mysql8](#連線-mysql8)
    - [mysql8 .env 預設連線](#mysql8-env-預設連線)
    - [mysql8 client 預設連線](#mysql8-client-預設連線)
  - [PHP 新服務所需樣板](#php-新服務所需樣板)
  - [本機服務互連](#本機服務互連)
  - [使用範例](#使用範例)
    - [php74](#php74)
      - [修改範例 php74 env](#修改範例-php74-env)
      - [啟動 php74 範例服務](#啟動-php74-範例服務)
      - [關閉 php74 範例服務](#關閉-php74-範例服務)
    - [php83](#php83)
      - [修改範例 php83 env](#修改範例-php83-env)
      - [啟動 php83 範例服務](#啟動-php83-範例服務)
      - [關閉 php83 範例服務](#關閉-php83-範例服務)
    - [laravel12](#laravel12)
      - [修改範例 laravel12 env](#修改範例-laravel12-env)
      - [啟動 laravel12 範例服務](#啟動-laravel12-範例服務)
      - [關閉 laravel12 範例服務](#關閉-laravel12-範例服務)
  - [樣板使用範例](#樣板使用範例)
    - [啟動服務](#啟動服務)
    - [關閉服務](#關閉服務)
  - [License](#license)

## 工具說明

工具使用 Traefik 做 Web 反向代理，讓各服務能自動註冊生效，無需反覆調整反向代設定，增加維護的彈性

## 環境準備

- 安裝 Docker 重開機後開啟 Docker
- 安裝 make
- 建立開發環境網路

```shell
docker network create dev-net
```

- 下載本工具

```shell
git clone git@github.com:gan068/traefik-web-dev-tools.git
```

- 複製服務設定

.env 內容可以視情況修改

```shell
cp .env.example .env
```

## 啟用反向代理 Traefik

```shell
# start
make web-up

# watch logs
make web-logs

# stop
make web-down
```

## 查看 Traefik Dashboard

http://localhost:8080

(預設 TRAEFIK_DASHBOARD_PORT=8080)

## 連線 redis

```shell
# start
make redis-up

# watch logs
make redis-logs

# stop
make redis-down
```

### redis .env 預設連線

REDIS_HOST=redis
REDIS_PORT=6379

### redis client 預設連線

host: 127.0.0.1
port: 6380

## 連線 mysql5.7

```shell
# start
make mysql57-up

# watch logs
make mysql57-logs

# stop
make mysql57-down
```

### mysql57 .env 預設連線

DB_HOST=mysql57
DB_USERNAME=root
DB_PASSWORD=root
DB_PORT=3306

### mysql57 client 預設連線

host: 127.0.0.1
user: root
password: root
port: 3307

## 連線 mysql8

```shell
# start
make mysql8-up

# watch logs
make mysql8-logs

# stop
make mysql8-down
```

### mysql8 .env 預設連線

DB_HOST=mysql8
DB_USERNAME=root
DB_PASSWORD=root
DB_PORT=3306

### mysql8 client 預設連線

host: 127.0.0.1
user: root
password: root
port: 3308

## PHP 新服務所需樣板

- templates/docker-compose.yml
- templates/cicd/local/nginx/default.conf.template

新服務皆以 .env 內的 APP_NAME 為 URL
樣板：http://${APP_NAME}.localhost

例如：APP_NAME=www
網址：http://www.localhost

## 本機服務互連

本機 web (APP_NAME=web)
http://web.localhost

連線到本機 api (APP_NAME=api)
http://api.localhost

在 web 內部連到 api URL 應定義為 http://api-nginx
若是 APP_NAME 有修改，則 URL 與內部 URL 皆會變更

## 使用範例

工具提供幾個個測試的專案如下

### php74

#### 修改範例 php74 env

```shell
cd php74
cp .env.example .env
```

#### 啟動 php74 範例服務

```shell
cd php74
docker compose up -d
```

即可用瀏覽器訪問

[http://php74.localhost](http://php74.localhost)

#### 關閉 php74 範例服務

```shell
cd php74
docker compose down
```

### php83

#### 修改範例 php83 env

```shell
cd php83
cp .env.example .env
```

#### 啟動 php83 範例服務

```shell
cd php83
docker compose up -d
```

即可用瀏覽器訪問

[http://php83.localhost](http://php83.localhost)

#### 關閉 php83 範例服務

```shell
cd php83
docker compose down
```

### laravel12

#### 修改範例 laravel12 env

```shell
cd laravel12
cp .env.example .env
```

#### 啟動 laravel12 範例服務

```shell
cd laravel12
comopser install
nvm use 22
npm install
docker compose up -d
```

即可用瀏覽器訪問

[http://laravel12.localhost](http://laravel12.localhost)

#### 關閉 laravel12 範例服務

```shell
cd laravel12
docker compose down
```

## 樣板使用範例

- 假設新專案為 code-igniter3
- 複製樣板
- 修改 code-igniter3/.env 的 APP_NAME 為 ci3


```shell
export TARGET_HOST=code-igniter3
cp ./templates/docker-compose.yml ${TARGET_HOST}/docker-compose.yml
cp ./templates/Dockerfile ${TARGET_HOST}/Dockerfile
cp ./templates/entrypoint.sh ${TARGET_HOST}/entrypoint.sh
cp ./templates/.env.example ${TARGET_HOST}/.env.example
cp ${TARGET_HOST}/.env.example ${TARGET_HOST}/.env
mkdir -p ${TARGET_HOST}/cicd/local/nginx \
&& cp ./templates/cicd/local/nginx/default.conf.template ${TARGET_HOST}/cicd/local/nginx/default.conf.template
```

### 啟動服務

```shell
export TARGET_HOST=code-igniter3
cd ${TARGET_HOST}/public
composer install
cd ../
docker compose up -d

# force rebuild docker image (optional)
docker compose up -d --build
```

- 瀏覽 web [http://ci3.localhost](http://ci3.localhost) 確認服務運行

### 關閉服務

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
