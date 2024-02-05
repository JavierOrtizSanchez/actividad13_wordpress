mariadb -u root <<< "DROP DATABASE IF EXISTS $WORDPRESS_DB_NAME"
mariadb -u root <<< "CREATE DATABASE $WORDPRESS_DB_NAME"
mariadb -u root <<< "DROP USER IF EXISTS $WORDPRESS_DB_USER@$IP_CLIENTE_MARIADB"
mariadb -u root <<< "CREATE USER $WORDPRESS_DB_USER@$IP_CLIENTE_MARIADB IDENTIFIED BY '$WORDPRESS_DB_PASSWORD'"

echo -e "<Directory /var/www/html/>\n\tAllowOverride All\n</Directory>" >> 000-default.conf

apt install wget -y
wget https://es.wordpress.org/latest-es_ES.zip -P /tmp
apt install unzip -y
sudo mv -f /tmp/wordpress/* /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo systemctl restart apache2

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/$WORDPRESS_DB_NAME/" /var/www/html/wp-config.php
sed -i "s/username_here/$WORDPRESS_DB_USER/" /var/www/html/wp-config.php
sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/" /var/www/html/wp-config.php
sed -i "s/localhost/$WORDPRESS_DB_HOST/" /var/www/html/wp-config.php