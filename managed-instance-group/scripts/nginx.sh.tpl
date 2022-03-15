# Disable the default NGINX configuration
rm /etc/nginx/sites-enabled/default

# Enable our NGINX configuration
cat > /etc/nginx/sites-available/${DOMAIN_NAME} << 'EOF'
server {
    listen 80;
    server_name ${DOMAIN_NAME} www.${DOMAIN_NAME};
    root /var/www/${DOMAIN_NAME};

    index index.html index.htm index.php;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF
ln -s /etc/nginx/sites-available/${DOMAIN_NAME} /etc/nginx/sites-enabled/

systemctl enable nginx
systemctl restart nginx
