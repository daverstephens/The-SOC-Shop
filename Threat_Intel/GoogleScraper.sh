sudo apt-get -y install git python3.5-dev virtualenv
virtualenv --python python3 env
source env/bin/activate
pip install git+git://github.com/NikolaiT/GoogleScraper/
