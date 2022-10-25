guest_ip  = "192.168.0.3"
script = 
"
sudo su -
apt update
apt install nginx -y
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
systemctl reload nginx

sudo apt install software-properties-common
yes '' | sudo add-apt-repository ppa:ondrej/php
sudo apt install php8.0 php8.0-fpm php8.0-mysql -y

apt install mariadb-server mariadb-client -y
echo 'create database if not exists appointments;' | mysql
echo 'create user if not exists tuan;' | mysql
echo 'grant all on appointments.* to tuan@localhost identified by \"tuanabc123\";' | mysql

sudo apt install git
cd /var/www/
git clone https://github.com/WordPress/WordPress.git
rm -r /var/www/html
mv WordPress tuantn.com
chown -R www-data:www-data /var/www/tuantn.com
"

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.network "private_network", ip: guest_ip
  config.vm.synced_folder "./conf.d", "/etc/nginx/conf.d"
  config.vm.provision "shell", inline: script
end
