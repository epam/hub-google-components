#!/bin/bash

set -e
export HOME=/root
export PHP_VERSION=8.1

# Install dependencies from apt
apt update
apt install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
curl -s -o - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
apt update
apt install -y \
        ${WEB_SERVER} \
        php$PHP_VERSION \
        php$PHP_VERSION-fpm \
        php$PHP_VERSION-mysql \
        php$PHP_VERSION-dev \
        php$PHP_VERSION-mbstring \
        php$PHP_VERSION-zip \
        php$PHP_VERSION-curl

# Installing wordpress
curl -L -O "https://wordpress.org/latest.tar.gz"
mkdir -p /var/www/${DOMAIN_NAME}
tar -xzf latest.tar.gz
mv ./wordpress/* /var/www/${DOMAIN_NAME}

# Generating WP config file
cat > /var/www/${DOMAIN_NAME}/wp-config.php << 'EOF'
<?php

define('DB_NAME', '${DB_NAME}');
define('DB_USER', '${DB_USER}');
define('DB_PASSWORD', '${DB_PASSWORD}');
define('DB_HOST', '${DB_HOST}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

${WP_SAlT}

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( strpos( $_SERVER['HTTP_X_FORWARDED_PROTO'], 'https' ) !== false ) {
    $_SERVER['HTTPS'] = 'on';
}
/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
EOF

# Change ownership and permissions for www-data user
chown -R www-data:www-data /var/www/
find /var/www/ -type f -exec chmod 644 {} \;
find /var/www/ -type d -exec chmod 755 {} \;
