#/!bin/sh
## $Id: viper-ubuntu.sh 24/07/2015 $
##
## script to install Viper on debian/ubuntu 14.04 minimal
##
## Authored by daverstephens@gmail.com
##
## https://github.com/daverstephens/The-SOC-Shop
##
## Start with a minimal install of 64bit Ubuntu Server 14.04
## which should include OpenSSH option selected during install
##
## Tested against Viper 1.3-dev
##
## Run the script as the standard user with the command below
## 
## sudo sh viper-ubuntu.sh 2>&1 | tee viper-ubuntu.log
##
## When the script has completed, check viper-ubuntu.log for errors
## and then complete the final activities listed at the end of this script

## Install latest updates
	apt-get -y update && apt-get -y upgrade
## Install dependencies
	env DEBIAN_FRONTEND=noninteractive apt-get -y install unzip build-essential python-dev python-pip git automake libtool libimage-exiftool-perl swig libssl-dev libfuzzy-dev
## Set build variables
printf "Enter the user who will run viper\n"
  read ViperUser
printf "Enter the full path to your temporary build directory\n"
  read TempPath
  [ ! -d $TempPath  ] && mkdir $TempPath
printf "Enter the full path to your desired Viper directory\nFor example /home/user\n"
  read ViperPath
  [ ! -d $ViperPath  ] && mkdir $ViperPath
cd $TempPath
## Install Yara
wget https://github.com/plusvic/yara/archive/master.zip
  unzip master.zip
  cd yara-*/
  bash build.sh
  make install
## Install PyDeep
cd yara-python/
  python setup.py install
  cd $TempPath
## Install SSDeep
wget http://sourceforge.net/projects/ssdeep/files/ssdeep-2.13/ssdeep-2.13.tar.gz/download
  mv download ssdeep.tar.gz
  tar zxf ssdeep.tar.gz
  cd ssdeep-*/
  ./configure
  make
  sudo make install
  cd $TempPath
## Install Python bindings
  pip install pydeep
## Install Androguard (Optional - Needed for .apk files)
wget https://androguard.googlecode.com/files/androguard-1.9.tar.gz
  tar zxf androguard-1.9.tar.gz
  cd androguard-1.9/
  python setup.py install
  cd $TempPath
## Install EXIFTool
git clone https://github.com/smarnach/pyexiftool
  cd pyexiftool
  sudo python setup.py install
## Install Viper
cd $ViperPath
  git clone https://github.com/botherder/viper
  chown -R $ViperUser:$ViperUser $ViperPath/viper 
  cd viper
  pip install -r requirements.txt
  ldconfig
## Test Install
yara --help|grep -q vmalvarez||echo "Yara :Install seems to have failed";
ssdeep -h|grep -q Kornblum||echo "SSDeep :Install seems to have failed";
## From the viper directory run Viper with './viper.py' for commandline interface or './web.py' for web interface
