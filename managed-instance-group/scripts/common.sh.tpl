#!/bin/bash

set -e
export HOME=/root
export PHP_VERSION=8.1

# Add Stackdriver Monitoring agent repo
curl -s https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh | sudo bash

# Add Stackdriver Logging agent repo
curl -s https://dl.google.com/cloudagents/add-logging-agent-repo.sh | sudo bash

# Install dependencies from apt
apt update
apt install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
# Add apt repo for php packages
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
curl -s -o - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
# Install
apt update
apt install -y \
        stackdriver-agent \
        google-fluentd \
        google-fluentd-catch-all-config \
        default-mysql-client \
        ${WEB_SERVER} \
        php$PHP_VERSION \
        php$PHP_VERSION-fpm \
        php$PHP_VERSION-mysql \
        php$PHP_VERSION-dev \
        php$PHP_VERSION-mbstring \
        php$PHP_VERSION-zip \
        php$PHP_VERSION-curl

# Start monitoring and logging agens
systemctl enable stackdriver-agent
systemctl start stackdriver-agent
systemctl enable google-fluentd
systemctl start google-fluentd

# Installing WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Installing wordpress
WP_CLI_ARGS="--path=/var/www/${DOMAIN_NAME} --allow-root"
mkdir -p /var/www/${DOMAIN_NAME}
wp core download $WP_CLI_ARGS
wp config create --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_PASSWORD}" --dbhost="${DB_HOST}" $WP_CLI_ARGS --extra-php << 'PHP'
if ( strpos( $_SERVER['HTTP_X_FORWARDED_PROTO'], 'https' ) !== false ) {
    $_SERVER['HTTPS'] = 'on';
}
PHP
wp core install --url=${DOMAIN_NAME} --title="Web server sandbox" --admin_user=admin --admin_password=strongpassword --admin_email=info@example.com --skip-email $WP_CLI_ARGS

# In order to run load generator
wp option update $WP_CLI_ARGS comment_previously_approved 0

# Change ownership and permissions for www-data user
chown -R www-data:www-data /var/www/
find /var/www/ -type f -exec chmod 644 {} \;
find /var/www/ -type d -exec chmod 755 {} \;
