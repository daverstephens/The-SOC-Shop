# Install Kibana on Ubuntu 16.04
#
#
# Not required if you have already installed Elasticsearch
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
#
sudo apt-get update && sudo apt-get install kibana
#
# run on boot
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
#
# manual start
sudo systemctl start kibana.service
#
# test
curl http://localhost:9200
