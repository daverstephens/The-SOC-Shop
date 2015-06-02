#/!bin/sh
## $Id: mwiki-post-install.sh 12/02/2015 $
##
## daverstephens@gmail.com
##
## script to finish install MediaWiki 1.24.1 on Ubuntu 14.04
## Add multiple extensions for SemanticMediaWiki operation
##
## $ sudo sh -x mwiki-post-install.sh 2>&1 | tee mwiki-post-install.log
##
## Script should be run after MWiki-Install.sh 
## and following webgui set-up of Mediawiki
##  
##
# Remove config directory
	rm -R /var/www/html/mediawiki/mw-config
# If server is hosted behind NAT then change $wgServer variable 
# to reflect public address
#	sed -i 's/http:\/\/x\.x\.x\.x/http:\/\/x\.x\.x\.x/g' /var/www/html/mediawiki/LocalSettings.php
# Install Git
	env DEBIAN_FRONTEND=noninteractive apt-get -y install git
# Install LinkTitles v3.0.1
	cd /tmp
	wget https://github.com/bovender/LinkTitles/blob/master/release/LinkTitles-3.1.0.tar.gz?raw=true
	mv LinkTitles-3.1.0.tar.gz?raw=true Linktitles.tar.gz
	tar xvf Linktitles.tar.gz
	rm Linktitles.tar.gz
	mv /tmp/LinkTitles /var/www/html/mediawiki/extensions
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
require_once( "\$IP/extensions/LinkTitles/LinkTitles.php" );
EOF
# Install Semantic Media Wiki - Open-source extension to MediaWiki
# that lets you store and query data within the wiki's pages.
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar /usr/local/bin/composer
	cd /var/www/html/mediawiki
	composer require mediawiki/semantic-media-wiki "~2.2"
	php /var/www/html/mediawiki/maintenance/update.php
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
enableSemantics( '172.21.1.100' );
EOF
# Install 'Admin Links' - Extension to MediaWiki that defines a special page,
# "Special:AdminLinks" that holds links meant to be helpful for wiki administrators
	cd /var/www/html/mediawiki/extensions
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
require_once( "\$IP/extensions/AdminLinks/AdminLinks.php" );
EOF
# Install 'Replace Text' - extension to MediaWiki that provides a special page
# to allow administrators to do a global string find-and-replace on both the 
# text and titles of the wiki's content pages.
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ReplaceText.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
require_once( "\$IP/extensions/ReplaceText/ReplaceText.php" );
EOF
# Install 'External Data' - extension allows MediaWiki pages to retrieve, filter
# and format structured data from one or more sources. These sources can include
# external URLs, regular wiki pages, uploaded files, files on the local server
# databases or LDAP directories.
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
include_once( "\$IP/extensions/ExternalData/ExternalData.php" );
EOF
# Install 'Semantic Drilldown' - extension to MediaWiki that provides a page 
# for drilling down through a site's data, using categories and filters on semantic
# properties.
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
include_once( "\$IP/extensions/SemanticDrilldown/SemanticDrilldown.php" );
EOF
# Install 'Semantic Forms is an extension to MediaWiki that allows users to add
# edit and query data using forms.
	git clone https://git.wikimedia.org/git/mediawiki/extensions/SemanticForms.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
include_once( "\$IP/extensions/SemanticForms/SemanticForms.php" );
EOF
# Install 'Semantic Compound Queries' - extension to MediaWiki, meant to work
# with Semantic MediaWiki, that allows for the display of more than one SMW 
# inline query in one results display set.
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticCompoundQueries.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
require_once( "\$IP/extensions/SemanticCompoundQueries/SemanticCompoundQueries.php" );
EOF
#
# Navigate to "Special:Version" on your wiki to verify that the extension is successfully installed.
# Log in as a user with administrator permission to your wiki and go to the page "Special:SMWAdmin":
#
# Click on the "Initialise or upgrade tables" button in the "Database installation and upgrade" 
# section to setup the database. Note that this requires permissions to alter/create database 
# tables, as explained at the top of this help page.
# Click on the "Start updating data" button in the "Data repair and upgrade" section to activate
# the automatic data update. Note that this takes some time; go to Special:SMWAdmin to follow its 
# progress. SMW can be used before this completes, but will not have access to all data yet 
# (e.g. page categories).
