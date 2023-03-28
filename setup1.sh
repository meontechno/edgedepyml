#!/bin/bash

echo -e "STEP-1: CHECK FOR ROOT USER"
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi

echo -e "STEP-2: MAKE SYSTEM UPDATES"
sudo apt-get update

echo -e "STEP-3: INSTALL PIP3"
sudo apt-get -y install python3-pip

echo -e "STEP-4: VERIFY PIP3 INSTALLATION"
pip3 --version

echo -e "STEP-5: VERIFYING IF DOCKER GROUP EXISTS AND ADDING USER"
if [ "$(grep docker /etc/group)" ]
then
    echo -e "docker group exists"
else
    groupadd docker
fi
usermod -aG docker $USER
exit
# newgrp docker #(or logout/login to activate the changes) ------ logging in the docker terminal if using newgrp
