FROM phpdockerio/php:8.1-cli

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php8.1-redis \
    php8.1-mbstring \
    php8.1-mysql \
    php8.1-intl \
    php8.1-interbase \
    php8.1-soap \
    php8.1-gd \
    php8.1-imagick \
    php8.1-opcache \
    php8.1-xdebug \
    php8.1-zip \
    php-pear php8.1-dev libmcrypt-dev gcc make autoconf libc-dev pkg-config \
    && pecl install mcrypt-1.0.5 \
    && pecl install redis \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

ADD ./php/php8/php.ini /etc/php/8.1/fpm/conf.d/90-php.ini
ADD ./php/php8/php.ini /etc/php/8.1/cli/conf.d/90-php.ini

COPY ./php/common/set_nginx_host.sh /set_nginx_host.sh
RUN chmod +x /set_nginx_host.sh

RUN apt-get update && apt-get install msmtp -y \
    && apt-get clean; rm -rf /var/lib/apt/lists/*

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
