#!/bin/bash
set -e



mkdir ~/resources
cp /vagrant/resources/* ~/resources/

cd /vagrant/

echo RUNNING PROVISION
scripts/000-provision.sh
echo RUNNING TUNE OS
scripts/010-tune-os.sh
echo RUNNING INSTALL CASSANDRA
scripts/020-cassandra.sh

chown -R vagrant /opt/cassandra/