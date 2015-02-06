#/!bin/sh
## $Id: mwiki-post-install.sh 20/01/2015 $
##
## daverstephens@gmail.com
##
## script to finish install MediaWiki 1.24.1 on Ubuntu 14.04
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
#	sed -i 's/http:\/\/10\.0\.1\.1/http:\/\/172\.21\.1\.1/g' /var/www/html/mediawiki/LocalSettings.php
# Install git
	apt-get install git
# Install LinkTitles v3.0.1
	cd /tmp
	wget https://github.com/bovender/LinkTitles/blob/master/release/LinkTitles-3.0.1.tar.gz?raw=true
	mv LinkTitles-3.0.1.tar.gz?raw=true Linktitles.tar.gz
	tar xvf Linktitles.tar.gz
	rm Linktitles.tar.gz
	mv /tmp/LinkTitles /var/www/html/mediawiki/extensions
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
require_once( "\$IP/extensions/LinkTitles/LinkTitles.php" );
EOF
# Install Semantic Media Wiki - Open-source extension to MediaWiki
# that lets you store and query data within the wiki's pages.
	php -r "readfile('https://getcomposer.org/installer');" | php
	php composer.phar require mediawiki/semantic-media-wiki "~2.0"
	php /var/www/html/mediawiki/maintenance/update.php
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
enableSemantics( '172.21.1.1' );
EOF
# Install 'Admin Links' - Extension to MediaWiki that defines a special page,
# "Special:AdminLinks" that holds links meant to be helpful for wiki administrators
	cd /var/www/html/mediawiki/extensions
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
require_once( "$IP/extensions/AdminLinks/AdminLinks.php" );
EOF
# Install 'Replace Text' - extension to MediaWiki that provides a special page
# to allow administrators to do a global string find-and-replace on both the 
# text and titles of the wiki's content pages.
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ReplaceText.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
require_once( "$IP/extensions/ReplaceText/ReplaceText.php" );
EOF
# Install 'External Data' - extension allows MediaWiki pages to retrieve, filter
# and format structured data from one or more sources. These sources can include
# external URLs, regular wiki pages, uploaded files, files on the local server
# databases or LDAP directories.
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
include_once( "$IP/extensions/ExternalData/ExternalData.php" );
EOF
# Install 'Semantic Drilldown' - extension to MediaWiki that provides a page 
# for drilling down through a site's data, using categories and filters on semantic
# properties.
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
include_once( "$IP/extensions/SemanticDrilldown/SemanticDrilldown.php" );
EOF
# Install 'Semantic Forms is an extension to MediaWiki that allows users to add
# edit and query data using forms.
	git clone https://git.wikimedia.org/git/mediawiki/extensions/SemanticForms.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
include_once( "$IP/extensions/SemanticForms/SemanticForms.php" );
EOF
# Install 'Semantic Compound Queries' - extension to MediaWiki, meant to work
# with Semantic MediaWiki, that allows for the display of more than one SMW 
# inline query in one results display set.
	git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticCompoundQueries.git
# Update localsettings.php
	cat >> /var/www/html/mediawiki/LocalSettings.php <<EOF
require_once( "$IP/extensions/SemanticCompoundQueries/SemanticCompoundQueries.php" );
EOF
