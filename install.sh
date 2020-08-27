#!/bin/bash

# IP
# ip addr show
# ip a

sudo clear

sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt install -y build-essential git wget curl tar gzip tasksel nano unrar p7zip-full p7zip-rar net-tools openssh-server stress-ng f2fs-tools htop lynx vim
sudo apt install -y linux-headers-`uname -r` -y
sudo apt install -y sqlite nodejs npm apt-transport-https python3-pip libssl-dev libffi-dev python3-dev python3-venv ruby-full 
sudo apt install -y php libapache2-mod-php php-mbstring php-xmlrpc php-soap php-gd php-xml php-cli php-zip composer 

clear
sleep 5

node --version
npm --version
php --version
composer --version
python3 --version
ruby --version
sleep 10

sudo apt update && sudo apt upgrade -y
sudo apt install -y sqlitebrowser gparted tmux terminator ca-certificates software-properties-common
sleep 10

# VSCode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code 
sleep 10

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt -f install 

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
sleep 10

# MySQL Workbench Community
wget http://cdn.mysql.com/Downloads/MySQLGUITools/mysql-workbench-community_8.0.21-1ubuntu20.04_amd64.deb -O mysql-workbench-community.deb
sudo apt -f install ./mysql-workbench-community.deb
sleep 10

# Mongodb Compass
wget https://downloads.mongodb.com/compass/mongodb-compass_1.21.2_amd64.deb
sudo apt -f install ./mongodb-compass_1.21.2_amd64.deb
sleep 10

# dbeaver
wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
sudo apt -f install ./dbeaver-ce_6.0.0_amd64.deb
sleep 10

# zoom
wget https://zoom.us/client/latest/zoom_amd64.deb -O zoom.deb
sudo apt -f install ./zoom.deb
sleep 10

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt -f install 
sudo apt install -y gnome-tweak-tool gnome-system-tools gnome-shell-extensions
#sudo apt install -y vlc gimp

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt -f install 
sudo apt install -y virtualbox virtualbox-ext-pack

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt -f install 

sudo npm install -g jshint jslint nodemon yarn browser-sync 

sudo cat .bashrc > /home/viviane/.bashrc

exit 0
