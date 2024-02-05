#!/bin/bash

apt update
apt install -y lamp-server
apt install -y mariadb-server

echo "DirectoryIndex index.html index.php" >> 000-default.conf
systemctl restart apache2
echo "<?php phpinfo(); ?>" > info.php

systemctl start mariadb
mysql_secure_installation

echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_APP_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $PHPMYADMIN_APP_PASSWORD" | debconf-setselections








