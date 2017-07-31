sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python-pip libssl-dev
sudo pip install lxml netaddr M2Crypto cherrypy mako requests bs4
sudo apt-get install python-m2crypto
wget -O spiderfoot.tar.gz https://downloads.sourceforge.net/project/spiderfoot/spiderfoot-2.10-src.tar.gz?r=http%3A%2F%2Fwww.spiderfoot.net%2Fdownload%2F&ts=1501506625&use_mirror=kent
tar xvf spiderfoot.tar.gz
rm spiderfoot.tar.gz
cd spider*
cat >> ./passwd <<EOF
spiderfoot:spiderfoot
EOF
