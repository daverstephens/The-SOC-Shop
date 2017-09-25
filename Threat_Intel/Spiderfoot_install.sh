sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python-pip libssl-dev python-m2crypto unzip
sudo pip install lxml netaddr M2Crypto cherrypy mako requests bs4
wget -O spiderfoot.zip https://github.com/smicallef/spiderfoot/archive/master.zip
tar xvf spiderfoot.zip
rm spiderfoot.zip
cd spider*
cat >> ./passwd <<EOF
spiderfoot:spiderfoot
EOF
sudo python ./sf.py 0.0.0.0:80
