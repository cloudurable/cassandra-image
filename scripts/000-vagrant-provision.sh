#!/bin/bash
set -e



mkdir ~/resources
cp -r /vagrant/resources/* ~/resources/

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


chown -R vagrant /opt/cassandra/


sysctl --system

chown -R vagrant /etc/cassandra/
#Nobody else can read the password file
chmod o-r /etc/cassandra/jmxremote.password
#Except this user
chmod u+r /etc/cassandra/jmxremote.password




