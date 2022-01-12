#!/bin/sh
sudo apt-get update
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get -y install golang
sudo npm install --global cdktf-cli@latest
