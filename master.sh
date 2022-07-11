#!/bin/bash

source /vagrant/provision_base.sh
yum install -y unzip

yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform
terraform version


yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
systemctl start docker

yum install epel-release -y
yum install jq -y

mkdir ~/learn-terraform-docker-container
cp /vagrant/*.tf  ~/learn-terraform-docker-container
