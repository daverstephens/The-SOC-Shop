# Install Elasticsearch on Ubuntu 16.04
#
#
# Pre-reqs
sudo apt-get install default-jre
#
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update && sudo apt-get install elasticsearch
#
# run on boot
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
#
# manual start
sudo systemctl start elasticsearch.service
#
# test
curl http://localhost:9200
