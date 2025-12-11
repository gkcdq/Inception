#!/bin/bash

# Define path to WordPress installation
WP_PATH=/var/www/html
CONFIG_FILE="$WP_PATH/wp-config.php"

if [ ! -f "$CONFIG_FILE" ]; then

	# Move to wordpress folder
	cd "$WP_PATH"

	# Download WordPress core
	wp core download --allow-root

	# Wait for MariaDB to be ready
	until mysqladmin ping -h mariadb -u${MYSQL_USER} -p${MYSQL_PASSWORD} --silent; do
		sleep 1
	done

	# Create wp-config.php
	wp config create \
		--dbname="${MYSQL_DATABASE}" \
		--dbuser="${MYSQL_USER}" \
		--dbpass="${MYSQL_PASSWORD}" \
		--dbhost="mariadb" \
		--allow-root

	# Install WordPress
	wp core install \
		--url="${DOMAIN_NAME}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--skip-email \
		--allow-root

	# Create an additional user
	wp user create \
		"${WP_USER}" "${WP_USER_EMAIL}" \
		--role=author \
		--user_pass="${WP_USER_PASSWORD}" \
		--allow-root

    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} \;
    find /var/www/html -type f -exec chmod 644 {} \;

fi

# Execute CMD from Dockerfile
exec /usr/sbin/php-fpm8.2 -F