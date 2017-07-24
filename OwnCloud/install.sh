sudo su
# pico /etc/hosts
#127.0.1.1 hostname
apt-get update && apt-get upgrade && apt-get dist-upgrade
sudo apt-get install apache2 mysql-server php php-bz2 php-curl php-gd php-imagick php-intl php-mbstring php-xml php-zip libapache2-mod-php php-mcrypt php-mysql
cd /var/www/html
sudo rm /var/www/html/index.html
sudo wget https://download.owncloud.org/community/owncloud-10.0.2.tar.bz2
sudo bzip2 -d owncloud-10.0.2.tar.bz2
sudo tar xvf owncloud-10.0.2.tar
sudo rm owncloud-10.0.2.tar
cd owncloud
sudo mv /var/www/html/owncloud/* /var/www/html/owncloud/.??* /var/www/html
cd ..
sudo rmdir owncloud
# Install CERTBot
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-apache
sudo certbot --apache
sudo mysql_secure_installation
sudo chown -R www-data:www-data /var/www
# Data Directory
sudo mkdir /home/cloudshare
sudo chown -R www-data:www-data /home/cloudshare
# MySQL Stuff
# mysql -u root -p
# CREATE DATABASE owncloud;
# GRANT ALL ON owncloud.* to 'owncloud'@'localhost' IDENTIFIED BY 'set_database_password';
# FLUSH PRIVILEGES;
# exit
#
sudo crontab -u www-data -e
# */15  *  *  *  * php -f /var/www/html/cron.php
#
# Test for cron job
crontab -u www-data -l
# */15  *  *  *  * php -f /var/www/html/cron.php
#
# Then under 'General - Cron' set the system to use cron scheduler.
# Enable HSTS
sudo pico /etc/apache2/sites-available/000-default-le-ssl.conf
# Within the <VirtualHost*:443> entry add:
#
# <IfModule mod_headers.c>
#   Header always set Strict-Transport-Security "max-age=15768000; includeSubDomains"
# </IfModule>
#
sudo a2enmod headers
sudo service apache2 restart
#
