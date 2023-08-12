#!/bin/bash

SCRIPT_PATH=$(dirname "${BASH_SOURCE[0]}")
source ${SCRIPT_PATH}/shared.inc.sh

# =======================

echo

# Check the version
#
version=$(lsb_release -rs)
if [[ "$version" != "20.04" &&  "$version" != "22.04" ]]; then
    printf $info "\nFound Ubuntu ${version}\n"
    printf $info "Error: This script requires Ubuntu 20.04 or 22.04\n\n"
    exit
fi

printf $info "\n-------- Installing Ddependencies --------\n\n"

sudo apt -y install curl gnupg gnupg2

sudo mkdir /etc/apt/keyrings/
sudo curl https://www.postgresql.org/media/keys/ACCC4CF8.asc --output /etc/apt/keyrings/postgresql.asc

sudo rm -f /etc/apt/sources.list.d/postgresql.list
echo "deb [signed-by=/etc/apt/keyrings/postgresql.asc] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee -a /etc/apt/sources.list.d/postgresql.list

sudo apt-get -y update

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    dirmngr \
    git \
    nano \
    net-tools \
    openjdk-11-jdk \
    openssl \
    software-properties-common \
    pwgen \
    qrencode \
    ufw \
    unzip \
    vim \
    wget \
    zip

# Firewall Rules
#
printf $info "\nAllow 22 [SSH]\n"
sudo ufw allow OpenSSH
echo
sudo ufw enable
printf $warning "\n\n------------ Current Firewall Rules ------------\n\n"
sudo ufw status verbose
