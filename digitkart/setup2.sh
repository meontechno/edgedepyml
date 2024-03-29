#!/bin/bash

echo Checking for root privileges... 
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi

echo Updating default runtime to nvidia...
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/digitkart/daemon.json -O /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker

echo Installing docker-compose dependencies...
pip3 install docker-compose

dir_path="/home/setup"
if [ ! -d $dir_path ]
then
mkdir $dir_path
fi
chmod 777 $dir_path

echo Downloading download-manager... 
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/digitkart/download_manager.sh -O $dir_path/download_manager.sh
chmod 777 $dir_path/download_manager.sh

echo Downloading service manager files... 
python_location=$(which python3)
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/digitkart/download_manager.service -O /etc/systemd/system/download_manager.service
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/digitkart/device_config.service -O /etc/systemd/system/device_config.service
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/digitkart/vision_ai.service -O /etc/systemd/system/vision_ai.service

echo Enabling services...
systemctl daemon-reload
systemctl enable download_manager.service
systemctl enable device_config.service
systemctl enable vision_ai.service
