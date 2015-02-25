#!/bin/bash

#Simple script used to look up via whois and host commands
#a series of domains.
#Writen by Sheldon Johnson 24/02/2014

################################################################################
#User Defined Constants
################################################################################

#Change the values of the variables below to suit your requirments.

PROJECTNAME="PROJECTNAMEHERE"
OUTDIR="$HOME/tmp/""$PROJECTNAME"

TLD[${#TLD[@]}]="tld1"
TLD[${#TLD[@]}]="tld2"

URI[${#URI[@]}]="domain1"
URI[${#URI[@]}]="domain2"

################################################################################
#Constants
################################################################################

OUTNAME="$OUTDIR/""$PROJECTNAME""."
HOSTDIR="$OUTDIR/hosts/"
WHOISDIR="$OUTDIR/whois/"
HOSTTEMP="$HOSTDIR""hosts.tmp"
HOSTIPV4="$HOSTDIR""hosts.ipv4.txt"
HOSTIPV6="$HOSTDIR""hosts.ipv6.txt"
NOREG="$WHOISDIR""not_registered"

################################################################################
#Setup
################################################################################

mkdir -p $OUTDIR
mkdir $HOSTDIR
mkdir $WHOISDIR
mdkir $NOREG
cd $OUTDIR

################################################################################
#Content
################################################################################

for j in ${URI[@]}; do
for i in ${TLD[@]}; do
URL=$j"."$i
host $URL | grep "has" > "$HOSTTEMP"
grep "has address" "$HOSTTEMP" >> "$HOSTIPV4"
grep "has IPv6 address" "$HOSTTEMP" >> "$HOSTIPV6"
whois $URL > "$WHOISDIR""$URL"".whois.txt"
done
done

rm "$HOSTTEMP"

################################################################################
#Final Output Notes
################################################################################

echo "Just a few tips..."
echo "The following lines will extract all the ipv4/6 addresses from your outputs:"
echo "cut -d \" \" -f 4 $HOSTIPV4 | sort -u"
echo "cut -d \" \" -f 5 $HOSTIPV6 | sort -u"

echo "The following line will simplify the outputs to make it more readable:"
echo "cut -d \" \" -f 1,4 $HOSTIPV4 | sort -u\""

echo "The following command will strip out all of the empty whois records:"
echo "find $WHOISDIR -type f -size -51c -exec rm {} $NOREG \;"

echo "This will remove all of the entries which returned the value \"This domain name has not been registered\":"

echo "for i in \$(find $WHOISDIR -maxdepth 1 -type f -exec ls {} \;); do grep \"This domain name has not been registered\" \$i > /dev/null; if [ $? == 0 ]; then mv \$i $NOREG; fi; done"
