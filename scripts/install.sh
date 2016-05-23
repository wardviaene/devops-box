#!/bin/bash
# create new ssh key
mkdir -p ~/.ssh
ssh-keygen -f ~/.ssh/mykey -N ''
# install packages
apt-get update
apt-get -y install docker.io ansible python-pip unzip
# install awscli
pip install awscli
cd /usr/local/bin
wget -q https://releases.hashicorp.com/terraform/0.6.16/terraform_0.6.16_linux_amd64.zip
unzip terraform_0.6.16_linux_amd64.zip
# clean up
apt-get clean
rm terraform_0.6.16_linux_amd64.zip
