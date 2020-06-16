#!/bin/sh
PACKER_VERSION="1.6.0"
sha256sum="FAILED"
retval=1
#echo $sha256sum
#echo $retval
mkdir download
cd download
while [ $sha256sum != "OK" ] || [ $retval -ne 0 ]; do
    wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS
    sha256sum=$(sha256sum -c packer_${PACKER_VERSION}_SHA256SUMS 2>&1 | grep packer_${PACKER_VERSION}_linux_amd64.zip | awk {'print $2'} >/dev/null && echo "OK" || echo "FAILED")
    #echo $sha256sum
    if [ $sha256sum = "OK" ]; then
		sudo unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin
		rm packer_${PACKER_VERSION}_linux_amd64.zip
		which packer
		packer -v
		retval=$?
		#echo $retval
		if [ $retval -eq 0 ]; then
			   break
		fi
    fi
done
cd ..
rm -rf download
