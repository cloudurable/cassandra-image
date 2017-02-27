#!/bin/bash
set -e


sudo cp -r /home/centos/resources/ /root/
sudo mv /home/centos/scripts/ /root/


echo RUNNING PROVISION
sudo /root/scripts/000-provision.sh
echo Building host file
sudo /root/scripts/002-hosts.sh
echo RUNNING TUNE OS
sudo /root/scripts/010-tune-os.sh
echo RUNNING INSTALL CASSANDRA
sudo /root/scripts/020-cassandra.sh
echo RUNNING INSTALL CASSANDRA CLOUD
sudo /root/scripts/030-cassandra-cloud.sh
echo RUNNING INSTALL CERTS
sudo /root/scripts/040-install-certs.sh
echo RUNNING SYTSTEMD SETUP
sudo /root/scripts/050-systemd-setup.sh


sudo chown -R cassandra /opt/cassandra/

sudo sysctl --system

sudo chown -R cassandra /etc/cassandra/

#Nobody else can read the password file
sudo chmod o-r /etc/cassandra/jmxremote.password
#Except this user
sudo chmod u+r /etc/cassandra/jmxremote.password


sudo mkdir  -p  /home/cassandra/.ssh/
sudo chown cassandra /home/cassandra/.ssh

sudo cp /home/centos/resources/server/certs/*  /home/cassandra/.ssh/

