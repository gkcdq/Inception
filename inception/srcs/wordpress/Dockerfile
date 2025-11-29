FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql php-xml php-gd php-mbstring wget unzip curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && rm latest.zip \
    && mv wordpress/* . \
    && rmdir wordpress

VOLUME ["/var/www/html"]

EXPOSE 9000

# PHP-FPM en foreground
CMD ["/usr/sbin/php-fpm8.2", "-F"]

