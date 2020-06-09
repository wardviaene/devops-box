#!/bin/sh
mkdir download
cd download
for version in `curl -s https://releases.hashicorp.com/packer/ | grep packer | cut -d/ -f3 | awk '{$1=$1};1'`; do
    wget -q https://releases.hashicorp.com/packer/${version}/packer_${version}_linux_amd64.zip \
    && wget -q https://releases.hashicorp.com/packer/${version}/packer_${version}_SHA256SUMS
    #sha256sum=$(sha256sum -c packer_${version}_SHA256SUMS | grep packer_${version}_linux_amd64.zip | awk {'print $2'} >/dev/null && echo "OK" || echo "FAILED") 
    sha256sum=$(sha256sum -c packer_${version}_SHA256SUMS | grep packer_${version}_linux_amd64.zip | cut -d: -f2 >/dev/null && echo "OK" || echo "FAILED") 
    if [ $sha256sum = "OK" ]; then
	echo $version
        break
    fi
done
cd ..
rm -rf download
