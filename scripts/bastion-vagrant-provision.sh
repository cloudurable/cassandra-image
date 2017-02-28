#!/bin/bash
set -e

yum install -y epel-release
yum update -y
yum install -y  ansible

mkdir /home/vagrant/resources
cp -r /vagrant/resources/* /home/vagrant/resources/

mkdir -p ~/resources
cp -r /vagrant/resources/* ~/resources/

mkdir  -p  /home/vagrant/.ssh/
cp /vagrant/resources/server/certs/*  /home/vagrant/.ssh/
/vagrant/scripts/002-hosts.sh
ssh-keyscan node0 node1 node2  >> /home/vagrant/.ssh/known_hosts


mkdir ~/playbooks
cp -r /vagrant/playbooks/* ~/playbooks/
cp /vagrant/resources/home/inventory.ini /etc/ansible/hosts
chown -R vagrant:vagrant /home/vagrant

# Setup ansible user
adduser ansible
usermod -aG wheel ansible

mkdir  -p  /home/ansible/.ssh/
cp ~/resources/server/certs/*  /home/ansible/.ssh/
chmod 400 /home/ansible/.ssh/*
chown -R ansible /home/ansible/.ssh/
