#!/bin/bash

echo -e "STEP-6: CHECK FOR ROOT USER"
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi

echo -e "STEP-7: SET NVIDIA AS DEFAULT CONTAINER IN RUN TIME"
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/daemon.json -O /etc/docker/daemon.json

echo -e "STEP-8: RESTART DOCKER DAEMON"
systemctl daemon-reload
systemctl restart docker

echo -e "STEP-9: INSTALLING REQUIRED PACKAGES"
pip3 install requests==2.26.*
pip3 install docker-compose
pip3 install httpx

echo -e "STEP-10: CONFIGURE DEVICE PARAMETERS"
dir_path="/home/setup"
if [ ! -d $dir_path ]
then
mkdir $dir_path
fi
chmod 777 $dir_path

echo -e "STEP-11: FILE UPDATE SCRIPTS"
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/config_update.service -O $dir_path/file_update.sh
chmod 777 $dir_path/file_update.sh

echo -e "STEP-12: UPDATE SYSTEMD SERVICES"
python_location=$(which python3)
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/config_update.service -O /etc/systemd/system/file_update.service
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/config_update.service -O /etc/systemd/system/device_config.service
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/dd5540f8e3e54e53ace3ca9b224a5f938b76083a/setup_scripts/config_update.service -O /etc/systemd/system/vision_ai.service
if [[ "$python_location" != *"/usr/bin/python3"* ]] #See how you can change the python location dynamically using sed
then
    echo -e "ERROR: PYTHON3 LOCATION NOT FOUND"
    exit
fi
systemctl daemon-reload
systemctl enable file_update.service
systemctl enable device_config.service
systemctl enable vision_ai.service
