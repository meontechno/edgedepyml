#!/bin/bash

sleep 30

# Application directory
dir_path="/home/setup"
if [ ! -d $dir_path ]; then
        echo CRITICAL ERROR: $dir_path does not exist
        exit
fi

serial=$(cat /proc/device-tree/serial-number)
echo -e "SERIAL_NUMBER="$serial > $dir_path/fedge-variables.env
chmod 777 $dir_path/fedge-variables.env

echo Downloading configuration files...
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/digitkart/device_config.py -O $dir_path/device_config.py
sleep 10
chmod 777 $dir_path/device_config.py
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/digitkart/dkart-docker-compose.yml -O $dir_path/docker-compose.yml
sleep 10
chmod 777 $dir_path/docker-compose.yml

var=$(python3 /home/setup/device_config.py)
echo $var
if [[ "$var" == "Login Succeeded"  ]]; then
        docker-compose -f /home/setup/docker-compose.yml up -d
else
        echo CRITICAL ERROR: Unable to login to docker...
fi
