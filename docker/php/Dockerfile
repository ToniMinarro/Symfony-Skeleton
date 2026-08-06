FROM php:8.4-fpm-alpine

RUN apk add --no-cache git libpq unzip \
    && apk add --no-cache --virtual .app-build-deps postgresql-dev \
    && docker-php-ext-install pdo_pgsql \
    && apk del .app-build-deps

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

RUN git config --global --add safe.directory /app

