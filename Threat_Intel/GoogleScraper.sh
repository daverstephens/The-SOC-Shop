#requirements: selenium wget python 2.7
 
import time
import sys
import wget
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.keys import Keys
 
def googlescrape(str):
    browser = webdriver.Firefox()
    browser.get(url)
    time.sleep(3) # sleep for 5 seconds so you can see the results
 
    results = browser.find_elements_by_css_selector('div.g')
    if len(results) == 0:
        print "No results found"
        browser.quit()
    else:
        for x in range(0,len(results)):
            link = results[x].find_element_by_tag_name("a")
            href = link.get_attribute("href")
            print href
            wget.download(href)
        browser.quit()
     
    return
 
 
 
 
 
if len(sys.argv) == 3:
    domain = sys.argv[1]
    ftype = sys.argv[2]
    url = "https://www.google.com/search?num=100&start=0&hl=em&meta=&q=site:"
    url += domain
    url += "+filetype:"
    url += ftype
    url += "&filter=0"
    googlescrape(url)
elif len(sys.argv) == 2:
 
    for i in range (0,3):
        if i==0:
            print "Checking for pdfs..."
            ftype = "pdf"
        elif i == 1:
            print "Checking for docs..."
            ftype = "doc"
        elif i == 2:
            print "Checking for xls..."
            ftype = "xls"
 
        domain = sys.argv[1]
        url = "https://www.google.com/search?num=100&start=0&hl=em&meta=&q=site:"
        url += domain
        url += "+filetype:"
        url += ftype
        url += "&filter=0"
        googlescrape(url)
 
         
             
 
else:
    print "Error: Improper number of arguments. Usage: python search.py domain.com pdf"
    sys.exit()
