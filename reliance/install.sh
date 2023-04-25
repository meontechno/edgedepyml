#!/bin/bash

echo Checking for root privileges 
if [ "$(id -u)" -ne 0 ]; then echo "You should have sudo privilege to run this script. Exiting..." >&2; exit 1; fi

echo Checking for updates... 
sudo apt-get update

echo Installing python package installer...
sudo apt-get -y install python3-pip

echo Installing docker-compose...
pip3 install requests==2.26.*
pip3 install httpx
pip3 install docker-compose

echo Updating default runtime to nvidia...
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/reliance/daemon.json -O /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker

# Application directory
dir_path="/home/setup"
if [ ! -d $dir_path ]
then
mkdir $dir_path
fi
chmod 777 $dir_path

echo Downloading download_manager... 
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/reliance/download_manager.sh -O $dir_path/download_manager.sh
chmod 777 $dir_path/download_manager.sh

echo Downloading service manager files... 
python_location=$(which python3)
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/reliance/download_manager.service -O /etc/systemd/system/download_manager.service

echo Enabling services...
systemctl daemon-reload
systemctl enable download_manager.service
