#!/bin/sh
mkdir download
cd download
for version in `curl -s https://releases.hashicorp.com/terraform/ | grep terraform | cut -d/ -f3 | awk '{$1=$1};1'`; do
    wget -q https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip \
    && wget -q https://releases.hashicorp.com/terraform/${version}/terraform_${version}_SHA256SUMS
    #sha256sum=$(sha256sum -c packer_${version}_SHA256SUMS 2>&1 | grep OK)
    #sha256sum=$(sha256sum -c terraform_0.12.26_SHA256SUMS | grep terraform_0.12.26_linux_amd64.zip | cut -d: -f2) 
    #sha256sum=$(sha256sum -c terraform_0.12.26_SHA256SUMS | grep terraform_0.12.26_linux_amd64.zip | awk {'print $2'} >/dev/null && echo "OK" || echo "FAILED") 
    #sha256sum=$(sha256sum -c terraform_0.12.26_SHA256SUMS | grep terraform_0.12.26_linux_amd64.zip | cut -d: -f2 >/dev/null && echo "OK" || echo "FAILED") 
    #sha256sum=$(sha256sum -c terraform_${version}_SHA256SUMS | grep terraform_${version}_linux_amd64.zip | awk {'print $2'} >/dev/null && echo "OK" || echo "FAILED") 
    sha256sum=$(sha256sum -c terraform_${version}_SHA256SUMS | grep terraform_${version}_linux_amd64.zip | cut -d: -f2 >/dev/null && echo "OK" || echo "FAILED") 
    if [ $sha256sum = "OK" ]; then
	echo $version
	sudo unzip -o terraform_${version}_linux_amd64.zip -d /usr/local/bin \
	&& rm terraform_${version}_linux_amd64.zip
        break
    fi
done
cd ..
rm -rf download
which terraform
terraform version
