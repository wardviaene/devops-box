#!/bin/bash
# create new ssh key
mkdir -p /home/ubuntu/.ssh
ssh-keygen -f /home/ubuntu/.ssh/mykey -N ''
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
# install packages
apt-get update
apt-get -y install docker.io ansible python-pip unzip
# add docker privileges
usermod -G docker ubuntu
# install awscli and ebcli
pip install awscli
pip install awsebcli
cd /usr/local/bin
wget -q https://releases.hashicorp.com/terraform/0.6.16/terraform_0.6.16_linux_amd64.zip
unzip terraform_0.6.16_linux_amd64.zip
# clean up
apt-get clean
rm terraform_0.6.16_linux_amd64.zip
