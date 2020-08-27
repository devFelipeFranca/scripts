#!/bin/bash

sudo clear

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sleep 10
sudo apt install -y docker-ce

# sudo usermod -aG docker ${USER}
# su - ${USER}
# id -nG
# sudo usermod -aG docker ${USER}
# docker --version

# sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/ docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose


sleep 5
