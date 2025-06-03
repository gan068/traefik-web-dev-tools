FROM php:8.3.9-fpm-alpine3.20

RUN apk update \
    && apk upgrade \
    && apk --progress --no-cache add \
    linux-headers \
    curl \
    autoconf \
    g++ \
    make \
    freetype \
    libpng \
    libjpeg-turbo \
    oniguruma \
    libwebp \
    libxpm \
    freetype-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    oniguruma-dev \
    libzip-dev \
    icu-dev \
    unzip \
    zip \
    wget

RUN docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-xpm \
    && docker-php-ext-install pdo pdo_mysql opcache gd zip sockets bcmath intl \
    && pecl install redis \
    && docker-php-ext-enable pdo pdo_mysql opcache redis sockets \
    && apk del freetype-dev libpng-dev libjpeg-turbo-dev libwebp-dev libxpm-dev oniguruma-dev \
    && rm -rf /var/cache/apk/*


WORKDIR /var/www/html


COPY . .

RUN addgroup -g 101 nginx && adduser -D -G nginx -u 101 nginx \
    && mv entrypoint.sh /entrypoint.sh \
    && chown -R nginx:nginx /var/www/html \
    && sed -i 's/user = www-data/user = nginx/' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/group = www-data/group = nginx/' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/listen.owner = www-data/listen.owner = nginx/' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/listen.group = www-data/listen.group = nginx/' /usr/local/etc/php-fpm.d/www.conf


ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000/tcp

CMD ["php-fpm","--nodaemonize"]
