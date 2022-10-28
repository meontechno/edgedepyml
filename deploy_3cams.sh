#!/bin/bash

./teardown.sh

sys_arc=$(uname -m)

echo -e "###Logging in to docker"
docker login -u meontechno -p 4535e86d-c3d0-41c1-9ae3-5bb9bbf45df4

echo -e "###Pulling container images"
docker pull meontechno/frictionless:3cam-seq

echo -e "###Downloading latest yml"
wget https://raw.githubusercontent.com/meontechno/edgedepyml/main/3cams.yml -O deploy.yml

echo -e "\n###Deploying frictionless vision service"
docker-compose -f deploy.yml up -d --remove-orphans
