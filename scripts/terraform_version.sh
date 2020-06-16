#!/bin/sh
TERRAFORM_VERSION="0.12.26"
sha256sum="FAILED"
retval=1
#echo $sha256sum
#echo $retval
mkdir download
cd download
while [ $sha256sum != "OK" ] || [ $retval -ne 0 ]; do
    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS
    sha256sum=$(sha256sum -c terraform_${TERRAFORM_VERSION}_SHA256SUMS 2>&1 | grep terraform_${TERRAFORM_VERSION}_linux_amd64.zip | awk {'print $2'} >/dev/null && echo "OK" || echo "FAILED")
    #echo $sha256sum
    if [ $sha256sum = "OK" ]; then
		sudo unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin
		rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
		which terraform
		terraform version
		retval=$?
		#echo $retval
		if [ $retval -eq 0 ]; then
			   break
		fi
    fi
done
cd ..
rm -rf download
