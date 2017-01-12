#!/bin/bash
set -e

cassandra_version=2.2.8

mkdir -p /opt/
cd /opt/
wget http://mirrors.sonic.net/apache/cassandra/$cassandra_version/apache-cassandra-$cassandra_version-bin.tar.gz
tar -xvf apache-cassandra-$cassandra_version-bin.tar.gz

rm *.tar.gz
mv apache-cassandra-$cassandra_version cassandra

cd /opt/cassandra

rm -rf javadoc
rm -rf doc
rm -rf interface
# rm -rf pylib/
rm NEWS.txt NOTICE.txt CHANGES.txt
cd bin
rm *.bat
rm *.ps1
# rm cqlsh
# rm cqlsh.py
# rm debug-cql


cd /opt/cassandra
cd conf
rm *.ps1
# rm cassandra-topology.properties
# rm cassandra-rackdc.properties
rm metrics-reporter-config-sample.yaml
rm cqlshrc.sample


mkdir -p /opt/cassandra/logs
mkdir -p /opt/cassandra/data
mkdir -p /opt/cassandra/commitlog
mkdir -p /opt/cassandra/savedcaches

cp ~/resources/cassandra.yaml /opt/cassandra/conf/

mkdir -p /etc/cassandra/
cp ~/resources/etc-cassie-jmxremote.password /etc/cassandra/jmxremote.password
chmod -r /etc/cassandra/jmxremote.password


cp ~/resources/start.sh /opt/cassandra/start.sh
