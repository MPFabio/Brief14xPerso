#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
#Installing Docker
sudo apt  install docker.io
#Creating container        
sudo docker run -d -p 5005:1234 --name tondocker fabiomp/fabio-brief14
