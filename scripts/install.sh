#!/bin/bash

# remove comment if you want to enable debugging
set -x

if [ -e /etc/redhat-release ] ; then
  REDHAT_BASED=true
fi

#TERRAFORM_VERSION=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
TERRAFORM_VERSION="0.12.25"
#TERRAFORM_VERSION="0.12.26"
#PACKER_VERSION=`curl -s https://api.github.com/repos/hashicorp/packer/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
PACKER_VERSION="1.5.4"
#AWS_EB_CLI_VERSION=`curl -s https://api.github.com/repos/aws/aws-elastic-beanstalk-cli-setup/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
AWS_EB_CLI_VERSION="3.12.0"

# create new ssh key
[[ ! -f /home/ubuntu/.ssh/mykey ]] \
&& mkdir -p /home/ubuntu/.ssh \
&& ssh-keygen -f /home/ubuntu/.ssh/mykey -N '' \
&& chown -R ubuntu:ubuntu /home/ubuntu/.ssh

# install packages
if [ ${REDHAT_BASED} ] ; then
  yum -y update
  yum install -y docker ansible unzip wget
else 
  apt-get update
  apt-get -y install docker.io ansible unzip python3-pip
fi

# add docker privileges
#usermod -G docker ubuntu
usermod -aG docker ubuntu
# install awscli and ebcli
#pip3 install -U awscli
#pip3 install -U awsebcli
pip3 install awscli -U
pip3 install awsebcli==${AWS_EB_CLI_VERSION} 

# terraform
# https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_windows_amd64.zip
T_VERSION=$(/usr/local/bin/terraform -v | head -1 | cut -d ' ' -f 2 | tail -c +2)
T_RETVAL=${PIPESTATUS[0]}

[[ $T_VERSION != $TERRAFORM_VERSION ]] || [[ $T_RETVAL != 0 ]] \
&& wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
&& wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS
sha256sum=$(sha256sum -c terraform_$TERRAFORM_VERSION_SHA256SUMS 2>&1 | grep OK)
#while [ "$sha256sum" != "OK" ]; do
#    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
#    && wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS
#    sha256sum=$(sha256sum -c terraform_$TERRAFORM_VERSION_SHA256SUMS 2>&1 | grep OK)
#    if [ "$sha256sum" = "OK" ]; then
#        break
#    fi
#done

unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
which terraform
terraform -v

# packer
# https://releases.hashicorp.com/packer/1.5.6/packer_1.5.6_windows_amd64.zip
P_VERSION=$(/usr/local/bin/packer -v)
P_RETVAL=$?

[[ $P_VERSION != $PACKER_VERSION ]] || [[ $P_RETVAL != 1 ]] \
&& wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
&& wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS \
sha256sum=$(sha256sum -c packer_${PACKER_VERSION}_SHA256SUMS 2>&1 | grep OK)
#while [ "$sha256sum" != "OK" ]; do
#    wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
#    && wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS
#    sha256sum=$(sha256sum -c packer_${PACKER_VERSION}_SHA256SUMS 2>&1 | grep OK)
#    if [ "$sha256sum" = "OK" ]; then
#        break
#    fi
#done

unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm packer_${PACKER_VERSION}_linux_amd64.zip
which packer
packer -v

# clean up
if [ ! ${REDHAT_BASED} ] ; then
  apt-get clean
fi
