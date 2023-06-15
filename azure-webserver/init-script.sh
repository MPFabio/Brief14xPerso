#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
sudo apt install curl
#Installing Docker
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
#Creating container
sudo docker build -t fabio-brief14 
sudo docker tag fabio-tp-game fabiomp/fabio-brief14
sudo docker login -u fabiomp -p Aucunmdp69
sudo docker push fabiomp/fabio-brief14           
sudo docker run -d -p 5005:1234 --name docker-nginx fabiomp/docker-nginx:latest
