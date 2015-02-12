#!/usr/bin/python

import requests, re, urllib, os

CIF_FILE_LOCATION="https://x.x.x.x/"
SITE_CONTENT = requests.get(CIF_FILE_LOCATION, verify=False).text
FIND_FILES = re.findall('.*.[0-9]{1,3}K|.*.[0-9]{1,5}.[0-9]{1,5}M|.*.[0-9]{1,5}.[0-9]{1,5}K|.*.[0-9]{1,3}M', SITE_CONTENT)
LINKS = re.findall('href="(.*?)"', str(FIND_FILES))



for link_type in LINKS:
	if "dom-" in link_type.lower():
		FILE_URL = CIF_FILE_LOCATION + link_type
		urllib.urlretrieve(FILE_URL, '/tmp/' + link_type)
		os.system("awk -F ',' -v comma=',' -v name='," + link_type + "' '{print $1 comma $9 comma $10 name}' /tmp/" + link_type + " >> /tmp/arcsight_dom.csv")
		os.system("awk -F ',' '{print $1}' /tmp/" + link_type + " >> /tmp/logrhythm_dom.csv")
		os.system("rm /tmp/" + link_type)

	if "inf-" in link_type.lower():
		urllib.urlretrieve(FILE_URL, '/tmp/' + link_type)
		os.system("awk -F ',' -v comma=',' -v name='," + link_type + "' '{print $1 comma $9 comma $10 name}' /tmp/" + link_type + " >> /tmp/arcsight_inf.csv")
		os.system("awk -F ',' '{print $1}' /tmp/" + link_type + " >> /tmp/logrhythm_inf.csv")
		os.system("rm /tmp/" + link_type)

	if "url-" in link_type.lower():
		urllib.urlretrieve(FILE_URL, '/tmp/' + link_type)
		os.system("awk -F ',' -v comma=',' -v name='," + link_type + "' '{print $1 comma $9 comma $10 name}' /tmp/" + link_type + " >> /tmp/arcsight_url.csv")
		os.system("awk -F ',' '{print $1}' /tmp/" + link_type + " >> /tmp/logrhythm_url.csv")
		os.system("rm /tmp/" + link_type)

	if "mal-" in link_type.lower():
		urllib.urlretrieve(FILE_URL, '/tmp/' + link_type)
		os.system("awk -F ',' -v comma=',' -v name='," + link_type + "' '{print $1 comma $9 comma $10 name}' /tmp/" + link_type + " >> /tmp/arcsight_mal.csv")
		os.system("awk -F ',' '{print $1}' /tmp/" + link_type + " >> /tmp/logrhythm_mal.csv")
		os.system("rm /tmp/" + link_type)

	if "eml-" in link_type.lower():
		urllib.urlretrieve(FILE_URL, '/tmp/' + link_type)
		os.system("awk -F ',' -v comma=',' -v name='," + link_type + "' '{print $1 comma $9 comma $10 name}' /tmp/" + link_type + " >> /tmp/arcsight_eml.csv") 
		os.system("awk -F ',' '{print $1}' /tmp/" + link_type + " >> /tmp/logrhythm_eml.csv")
		os.system("rm /tmp/" + link_type)

os.system("sed -i '/# address.*./d' /tmp/*.csv")

