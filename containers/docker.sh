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
# sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


sleep 5

# docker volume create portainer_data
# docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

# docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)
