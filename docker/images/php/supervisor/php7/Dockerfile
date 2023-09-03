FROM php:7.4.13-cli-alpine

ENV TZ="Europe/Moscow"
RUN apk --no-cache update \
    && apk --no-cache upgrade \
    && apk add --no-cache --virtual \
        .build-deps \
        $PHPIZE_DEPS \
        gcc \
        g++ \
        autoconf \
        tar \
    && apk add --no-cache \
        fcgi \
        bash \
        bzip2-dev \
        curl-dev \
        freetds-dev \
        freetype \
        freetype-dev \
        gettext \
        gettext-dev \
        gmp-dev \
        icu-dev \
        imagemagick \
        imagemagick-libs \
        imap-dev \
        jpegoptim \
        libintl \
        libjpeg-turbo \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        libxslt-dev \
        libzip-dev \
        make \
        device-mapper \
        libseccomp \
        iptables \
        ip6tables \
        mysql-client \
        oniguruma-dev \
        openldap-dev \
        openssh \
        openssl \
        pngquant \
        tidyhtml-dev \
        wget \
        zip \
        unzip git \
        msmtp \
        supervisor \
    && phpModules=" \
            bcmath \
            bz2 \
            iconv \
            exif \
            gd \
            gettext \
            fileinfo \
            gmp \
            imap \
            intl \
            ldap \
            mysqli \
            pcntl \
            pdo_dblib \
            pdo_mysql \
            pdo \
            soap \
            sockets \
            xsl \
            zip \
            dom \
            opcache \
        " \
    && NPROC=$(getconf _NPROCESSORS_ONLN) \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && mkdir -p /usr/src/php/ext/imagick \
    && curl -fsSL https://pecl.php.net/get/imagick | tar xvz -C "/usr/src/php/ext/imagick" --strip 1 \
    && docker-php-ext-install -j${NPROC} $phpModules \
    && apk del --no-cache gcc g++ freetype-dev libpng-dev libjpeg-turbo-dev .build-deps

RUN mkdir -p /tmp/pear/cache \
	&& chmod a=rwx /tmp/pear/cache

RUN apk add php7-pecl-xdebug
#RUN apk add php7-pecl-apcu
RUN apk add -U shadow
RUN addgroup www-data root
RUN mkdir -p "/var/log/php" && chmod 777 /var/log/php
RUN touch /var/log/php/error.log && touch /var/log/php/php-slow.log && chown www-data:www-data -R /var/log/php/*

COPY ./php/php7/php-fpm.d /usr/local/etc/php-fpm.d
COPY ./php/php7/conf.d /usr/local/etc/php/conf.d
COPY ./php/php7/php.ini $PHP_INI_DIR/php.ini

COPY ./php/common/set_nginx_host.sh /set_nginx_host.sh
RUN chmod +x /set_nginx_host.sh
COPY ./php/common/msmtp_php /etc/msmtprc
RUN chown -R www-data:www-data /tmp
COPY ./php/common/entrypoint.sh /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint
ENV TMPDIR="/tmp"
RUN usermod -u 1000 www-data

RUN mkdir -p /var/log/supervisor && mkdir -p /etc/supervisor/conf.d
COPY ./php/supervisor/conf.d /etc/supervisor/conf.d
COPY ./php/common/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
