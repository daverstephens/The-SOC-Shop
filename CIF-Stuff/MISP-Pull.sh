#/!bin/sh
## $Id: misp-pull.sh 04/03/2015 $
##
## script to pull data from a MISP instance
##
## Authored by daverstephens@gmail.com
##
## https://github.com/daverstephens/The-SOC-Shop
/usr/bin/curl -H "Authorization: ***INSERT AUTHKEY HERE***" http://X.X.X.X/attributes/text/download/md5/ > /home/cif/misp/md5.txt
/usr/bin/curl -H "Authorization: ***INSERT AUTHKEY HERE***" http://X.X.X.X/attributes/text/download/sha1/ > /home/cif/misp/sha1.txt
/usr/bin/curl -H "Authorization: ***INSERT AUTHKEY HERE***" http://X.X.X.X/attributes/text/download/ip-src/ > /home/cif/misp/ip-src.txt
/usr/bin/curl -H "Authorization: ***INSERT AUTHKEY HERE***" http://X.X.X.X/attributes/text/download/ip-dst/ > /home/cif/misp/ip-dst.txt
/usr/bin/curl -H "Authorization: ***INSERT AUTHKEY HERE***" http://X.X.X.X/attributes/text/download/hostname/ > /home/cif/misp/hostname.txt
/usr/bin/curl -H "Authorization: ***INSERT AUTHKEY HERE***" http://X.X.X.X/attributes/text/download/domain/ > /home/cif/misp/domain.txt
/usr/bin/curl -H "Authorization: ***INSERT AUTHKEY HERE***" http://X.X.X.X/attributes/text/download/url/ > url.txt
##
## Options for plain txt export are as follows
##
## http://x.x.x.x/attributes/text/download/md5
## http://x.x.x.x/attributes/text/download/sha1
## http://x.x.x.x/attributes/text/download/sha256
## http://x.x.x.x/attributes/text/download/filename
## http://x.x.x.x/attributes/text/download/filename|md5
## http://x.x.x.x/attributes/text/download/filename|sha1
## http://x.x.x.x/attributes/text/download/filename|sha256
## http://x.x.x.x/attributes/text/download/ip-src
## http://x.x.x.x/attributes/text/download/ip-dst
## http://x.x.x.x/attributes/text/download/hostname
## http://x.x.x.x/attributes/text/download/domain
## http://x.x.x.x/attributes/text/download/email-src
## http://x.x.x.x/attributes/text/download/email-dst
## http://x.x.x.x/attributes/text/download/email-subject
## http://x.x.x.x/attributes/text/download/email-attachment
## http://x.x.x.x/attributes/text/download/url
## http://x.x.x.x/attributes/text/download/## http-method
## http://x.x.x.x/attributes/text/download/user-agent
## http://x.x.x.x/attributes/text/download/regkey
## http://x.x.x.x/attributes/text/download/regkey|value
## http://x.x.x.x/attributes/text/download/AS
## http://x.x.x.x/attributes/text/download/snort
## http://x.x.x.x/attributes/text/download/pattern-in-file
## http://x.x.x.x/attributes/text/download/pattern-in-traffic
## http://x.x.x.x/attributes/text/download/pattern-in-memory
## http://x.x.x.x/attributes/text/download/yara
## http://x.x.x.x/attributes/text/download/vulnerability
## http://x.x.x.x/attributes/text/download/attachment
## http://x.x.x.x/attributes/text/download/malware-sample
## http://x.x.x.x/attributes/text/download/link
## http://x.x.x.x/attributes/text/download/comment
## http://x.x.x.x/attributes/text/download/text
## http://x.x.x.x/attributes/text/download/other
## http://x.x.x.x/attributes/text/download/named pipe
## http://x.x.x.x/attributes/text/download/mutex
## http://x.x.x.x/attributes/text/download/target-user
## http://x.x.x.x/attributes/text/download/target-email
## http://x.x.x.x/attributes/text/download/target-machine
## http://x.x.x.x/attributes/text/download/target-org
## http://x.x.x.x/attributes/text/download/target-location
## http://x.x.x.x/attributes/text/download/target-external

