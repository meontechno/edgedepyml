#!/bin/bash

# Check for .setup directory, else create
dir_path="/home/setup"
if [ ! -d $dir_path ]
then
echo -e "CRITICAL ERROR: $dir_path does not exist"
exit
fi

# Store device parameters
serial=$(cat /proc/device-tree/serial-number)
echo -e "SERIAL-NUMBER="$serial > $dir_path/fedge-variables.env

# Download device_config and docker-compose
echo "### Downloading configuration files..."
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/7f3c15402edcc8b23220a7707342e52c7c43fe1d/setup_scripts/device_config.py -O $dir_path/device_config.py
wget https://bitbucket.org/nsanjay/frictionless_weights/raw/7f3c15402edcc8b23220a7707342e52c7c43fe1d/setup_scripts/docker-compose.yml -O $dir_path/docker-compose.yml
