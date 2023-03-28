#!/bin/bash

echo Checking for root privileges 
if [ "$(id -u)" -ne 0 ]; then echo "You should have sudo privilege to run this script. Exiting..." >&2; exit 1; fi

echo Checking for updates... 
sudo apt-get update

echo Installing python package installer...
sudo apt-get -y install python3-pip

echo Installing docker-compose dependencies...
pip3 install requests==2.26.*
pip3 install httpx

echo Configuring docker for non-root user
if [ "$(grep docker /etc/group)" ]
then
    echo docker group already exists
else
    groupadd docker
fi
usermod -aG docker $USER
exit
# newgrp docker #(restart to activate the changes)
