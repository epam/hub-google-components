# Install apache php module
apt install -y libapache2-mod-php$PHP_VERSION

cat > /etc/apache2/sites-available/${DOMAIN_NAME}.conf <<'EOF'
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName ${DOMAIN_NAME}
    ServerAlias www.${DOMAIN_NAME}
    DocumentRoot /var/www/${DOMAIN_NAME}
    ErrorLog $${APACHE_LOG_DIR}/error.log
    CustomLog $${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Check configuration
a2ensite ${DOMAIN_NAME}.conf
a2dissite 000-default.conf
apache2ctl configtest

systemctl enable apache2
systemctl restart apache2
