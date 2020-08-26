
#!/bin/bash

# IP
# ip addr show
# ip a

sudo clear

sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt install -y build-essential git wget curl tar gzip tasksel nano unrar p7zip-full p7zip-rar net-tools nmap openssh-server stress-ng f2fs-tools smem htop speedtest-cli lynx vim
sudo apt install -y linux-headers-`uname -r` -y
sudo apt install -y sqlite nodejs npm apt-transport-https python3-pip libssl-dev libffi-dev python3-dev python3-venv ruby-full 
sudo apt install -y php libapache2-mod-php php-mbstring php-xmlrpc php-soap php-gd php-xml php-cli php-zip composer 
