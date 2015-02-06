#/!bin/sh
## $Id: ubuntu-mwiki-install.sh 20/01/2015 $
##
## daverstephens@gmail.com
##
## script to install MediaWiki 1.24.1 on Ubuntu 14.04
##
## $ sudo sh -x MWiki-Install.sh 2>&1 | tee MWiki-Install.log
##
##
## First perform base install of Ubuntu 14.04 to include 
## OpenSSH and LAMP Server options. 
##
# Install latest updates
	env DEBIAN_FRONTEND=noninteractive apt-get -y update && apt-get -y upgrade
# Download and install MediaWiki 1.24.1
	cd /tmp
	wget http://releases.wikimedia.org/mediawiki/1.24/mediawiki-1.24.1.tar.gz
	tar zxvf mediawiki-1.24.1.tar.gz
	mkdir -p /var/www/html/mediawiki
	mv mediawiki-1.24.1/* /var/www/html/mediawiki
	chown www-data:www-data /var/www/html/mediawiki
	chmod a+w /var/www/html/mediawiki/images
# Create MySQL Database
	mysql -u root -ppassword << EOF
CREATE DATABASE mediawikidb;
CREATE USER admin@localhost IDENTIFIED BY 'password';
GRANT index, create, select, insert, update, delete, alter, lock tables on mediawikidb.* TO admin@localhost;
FLUSH PRIVILEGES;
exit
EOF
# Restart Apache services
	service apache2 restart
	service mysql restart
## Install SNMP Daemon
	apt-get -y install snmpd
##
## SNMP Agent config
	cat > /etc/snmp/snmpd.conf << EOF
rocommunity public
syslocation "whatever"
syscontact whatever
sysname whatever
EOF
##
## sed -i "/^SNMPDOPTS=.*/SNMPDOPTS=\'-Lsd -Lf \/dev\/null -u snmp -I -smux -p \/var\/run\/snmpd\.pid -c \/etc\/snmp\/snmpd\.conf\'" /etc/default/snmpd
## Restart SNMP Daemon
	/etc/init.d/snmpd restart
## Now continue install via the web interface http://ip_address/mediawiki/mw-config/index.php
## 
## Database type    MySQL
## Database host    localhost
## Database name    mediawikidb
## Database prefix    mdx  (or any value of your choice)
## Database username    admin
## Database password    password
## 
