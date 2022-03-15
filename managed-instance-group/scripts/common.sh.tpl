#!/bin/bash

set -e
export HOME=/root
export PHP_VERSION=8.1
# export JOOMLA_VERSION=4-1-0
# export JOOMLA_PACKAGE=Joomla_$JOOMLA_VERSION-Stable-Full_Package

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

# Installing Joomla
# curl -L -O "https://downloads.joomla.org/cms/joomla$(echo $JOOMLA_VERSION | cut -d - -f 1)/$JOOMLA_VERSION/$JOOMLA_PACKAGE.tar.bz2"
mkdir -p /var/www/${DOMAIN_NAME}
# tar -xjf $JOOMLA_PACKAGE.tar.bz2 -C /var/www/${DOMAIN_NAME}

cat > /var/www/${DOMAIN_NAME}/index.php << 'EOF'
<?php
    phpinfo();
?>
EOF

# Change ownership and permissions for www-data user
chown -R www-data:www-data /var/www/
find /var/www/ -type f -exec chmod 644 {} \;
find /var/www/ -type d -exec chmod 755 {} \;
