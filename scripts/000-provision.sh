#!/bin/bash
set -e

yum install -y epel-release
yum update -y

yum install -y wget
yum install -y nano
yum install -y java-1.8.0-openjdk
yum install -y ntp
yum install -y jna

yum install -y jemalloc
yum install -y net-tools


# Setup ansible user
adduser ansible
usermod -aG wheel ansible

mkdir  -p  /home/ansible/.ssh/
cp ~/resources/server/certs/*  /home/ansible/.ssh/
chmod 400 /home/ansible/.ssh/*
chown -R ansible /home/ansible/.ssh/
