#!/bin/bash

# setup nginx
sudo su -
apt update
apt install nginx -y
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

# install php and php-extenssion
sudo apt install software-properties-common
yes '' | sudo add-apt-repository ppa:ondrej/php
sudo apt install php8.0 php8.0-fpm php8.0-mysql -y

# setup db
apt install mariadb-server mariadb-client -y
echo 'create database if not exists top6vn;' | mysql
echo 'create user if not exists tuantn;' | mysql
echo 'grant all on top6vn.* to tuantn@localhost identified by "tuantn";' | mysql

# install git and setup source code
sudo apt install git
cd /var/www/
git clone https://github.com/WordPress/WordPress.git
rm -r /var/www/html
mv WordPress top6vn.com
chown -R www-data:www-data /var/www/top6vn.com

# setup config for nginx
git clone https://github.com/trinhngoctuan1509/nginx_config_top6vn_http.git
cp /var/www/nginx_config_top6vn_http/top6vn.com.conf /etc/nginx/conf.d/top6vn.com.conf
rm -r /var/www/nginx_config_top6vn_http
systemctl reload nginx