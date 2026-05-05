FROM alpine:3.21

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN set -ex \
    && apk add --no-cache \
        ca-certificates curl wget tar xz tzdata pcre \
        php83 \
        php83-bcmath \
        php83-curl \
        php83-ctype \
        php83-dom \
        php83-fileinfo \
        php83-gd \
        php83-iconv \
        php83-mbstring \
        php83-mysqlnd \
        php83-openssl \
        php83-pdo \
        php83-pdo_mysql \
        php83-pdo_pgsql \
        php83-pdo_sqlite \
        php83-phar \
        php83-posix \
        php83-redis \
        php83-sockets \
        php83-sodium \
        php83-sysvshm \
        php83-sysvmsg \
        php83-sysvsem \
        php83-simplexml \
        php83-tokenizer \
        php83-zip \
        php83-zlib \
        php83-xml \
        php83-xmlreader \
        php83-xmlwriter \
        php83-pcntl \
        php83-opcache \
        php83-pecl-swoole \
        php83-pecl-protobuf \
        libstdc++ openssl c-ares libpq protobuf gnu-libiconv \
    && ln -sf /usr/bin/php83 /usr/bin/php \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer config -g repos.packagist composer https://mirrors.aliyun.com/composer/

RUN echo "memory_limit=1G" >> /etc/php83/conf.d/99-custom.ini \
    && echo "upload_max_filesize=128M" >> /etc/php83/conf.d/99-custom.ini \
    && echo "post_max_size=128M" >> /etc/php83/conf.d/99-custom.ini \
    && echo "opcache.enable_cli=0" >> /etc/php83/conf.d/99-opcache.ini \
    && echo "swoole.use_shortname=Off" >> /etc/php83/conf.d/99-swoole.ini

ENV LD_PRELOAD=/usr/lib/preloadable_libiconv.so

VOLUME /var/www
WORKDIR /var/www