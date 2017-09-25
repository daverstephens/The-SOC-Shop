sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python-pip libssl-dev
sudo pip install lxml netaddr M2Crypto cherrypy mako requests bs4
sudo apt-get install python-m2crypto
wget -O spiderfoot.tar.gz https://github.com/smicallef/spiderfoot/archive/master.zip
tar xvf spiderfoot.tar.gz
rm spiderfoot.tar.gz
cd spider*
cat >> ./passwd <<EOF
spiderfoot:spiderfoot
EOF
python ./sf.py 0.0.0.0:80
