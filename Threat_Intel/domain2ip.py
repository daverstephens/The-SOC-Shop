#
# Provide a list of domain names, 1 per line, in a file called 
# domainlist in the same directory as this script and then run
# this script to resolve domains to IP addresses
#
import socket

domainlist = []
with open("./domainlist") as file:
    for line in file:
        line = line.strip()
        domainlist.append(line)

for item in domainlist:
    try:
        domainitem = socket.gethostbyname_ex(item)
        print domainitem[0], domainitem[2]
    except socket.gaierror:
        print("{} does not have an IP address".format(item))
