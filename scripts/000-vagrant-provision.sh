#!/bin/bash
set -e



mkdir ~/resources
cp -r /vagrant/resources/* ~/resources/

mkdir -p /home/vagrant/resources
cp -r /vagrant/resources/* /home/vagrant/resources/

mkdir  -p  /home/vagrant/.ssh/
cp /vagrant/resources/server/certs/*  /home/vagrant/.ssh/
chmod 400 /home/vagrant/.ssh/*
chown -R vagrant /home/vagrant/.ssh/


cd /vagrant/

echo RUNNING PROVISION
scripts/000-provision.sh
echo Building host file
scripts/002-hosts.sh
echo RUNNING TUNE OS
scripts/010-tune-os.sh
echo RUNNING INSTALL CASSANDRA
scripts/020-cassandra.sh
echo RUNNING INSTALL CASSANDRA CLOUD
scripts/030-cassandra-cloud.sh
echo RUNNING INSTALL CERTS
scripts/040-install-certs.sh
echo RUNNING SYTSTEMD SETUP
scripts/050-systemd-setup.sh


chown -R cassandra /opt/cassandra/

sysctl --system

chown -R cassandra /etc/cassandra/

#Nobody else can read the password file
chmod o-r /etc/cassandra/jmxremote.password
#Except this user
chmod u+r /etc/cassandra/jmxremote.password




