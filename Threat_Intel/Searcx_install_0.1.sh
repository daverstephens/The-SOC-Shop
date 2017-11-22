sudo apt-get update
sudo apt-get install git build-essential libxslt-dev python-dev python-virtualenv python-pybabel zlib1g-dev libffi-dev libssl-dev python-pip
cd /usr/local
git clone https://github.com/asciimoo/searx.git
cd searx
./manage.sh update_packages
sed -i -e "s/ultrasecretkey/`openssl rand -hex 16`/g" searx/settings.yml
# Edit address to bind to if required
#
#nano -w searx/settings.yml
#
#bind_address : “127.0.0.1”
#
# To start
#cd ~/searx/searx/searx
#python webapp.py
