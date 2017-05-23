#
# This script will ask for an input file which it will 
# check against a csv called 'TI_Request_DB.csv' and,
# assuming the URL or IP from the input file doesn't
# exist in the csv, it will submit it to Bluecoat and
# return the site review categories for that IP or URL
#

import csv
import requests
from bs4 import BeautifulSoup
from random import randint
from time import sleep

# Storage lists

TI_Raw_Data_List = []
Processed_TI_List = []
Bluecoat_Tmp_List = []
Seen_Before_List = []
Output_List = []

# Function to check Bluecoat Sitereview
def SiteReview(URL):
    sleep(randint(4,10))
    category_check = requests.post("http://sitereview.bluecoat.com/rest/categorization", data = {'url':URL})
    if category_check.status_code != 200:
        Processed_TI_List.append("{} could not be checked. Status {} was returned.".format(line, category_check.status_code))
    else:
        soup = BeautifulSoup(category_check.text, "lxml")
        for category in soup.findAll('a'):
            Processed_TI_List.append("{} is category {}".format(line, category.get_text()))

# Input TI text file location

TI_Input_File = raw_input("Enter the location of the Threat Intelligence input text file: eg ./threatintel.txt\n")

# Perform initial sift of intel data

with open(TI_Input_File) as infile:
    for line in infile:
        line = line.lower()
        replacements = {'[.]':'.'}
        for src, target in replacements.iteritems():
            line = line.replace(src, target)
        TI_Raw_Data_List.append(line.rstrip())

with open('TI_Request_DB.csv', 'r') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    for row in reader:
        for line in TI_Raw_Data_List:
            if line == row[0]:
                Processed_TI_List.append("{} has been requested before".format(line))
                if line not in Seen_Before_List:
                    Seen_Before_List.append(line)
            else:
                if line not in Bluecoat_Tmp_List:
                    Bluecoat_Tmp_List.append(line)

Bluecoat_List = set(Bluecoat_Tmp_List).difference(Seen_Before_List)

for line in Bluecoat_List:
    SiteReview(line)

with open('TI_Request_DB.csv', 'a') as csvfile:
    for line in TI_Raw_Data_List:
        fields = [line]
        writer = csv.writer(csvfile)
        writer.writerow(fields)

for line in Processed_TI_List:
    replacements = {'.':'[.]'}
    for src, target in replacements.iteritems():
        line = line.replace(src, target)
    Output_List.append(line.rstrip())

for item in Output_List:
    print(item)
