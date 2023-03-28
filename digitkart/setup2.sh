#!/bin/bash

echo Checking for root privileges... 
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi

echo Updating default runtime to nvidia...
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/daemon.json -O /etc/docker/daemon.json
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

echo Downloading device config files... 
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/config_update.service -O $dir_path/file_update.sh
chmod 777 $dir_path/file_update.sh

echo Downloading service manager files... 
python_location=$(which python3)
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/config_update.service -O /etc/systemd/system/file_update.service
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/config_update.service -O /etc/systemd/system/device_config.service
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/config_update.service -O /etc/systemd/system/vision_ai.service

echo Enabling services...
systemctl daemon-reload
systemctl enable file_update.service
systemctl enable device_config.service
systemctl enable vision_ai.service
