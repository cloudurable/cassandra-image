#!/bin/bash
set -e


cassandra_version=3.9

echo "Install Cassandra"
mkdir -p /opt/
cd /opt/
cp ~/resources/opt/apache-cassandra-${cassandra_version}-bin.tar.gz .
tar -xvf apache-cassandra-${cassandra_version}-bin.tar.gz

rm *.tar.gz
mv apache-cassandra-${cassandra_version} cassandra




echo "Remove unwanted files"
cd /opt/cassandra
rm -rf javadoc
rm -rf doc
rm -rf interface
head -100 NEWS.txt
head -100 NOTICE.txt
head -100 CHANGES.txt
rm NEWS.txt NOTICE.txt CHANGES.txt
cd bin
rm *.bat
rm *.ps1



echo "Remove unwanted config"
cd /opt/cassandra
cd conf
rm *.ps1
rm metrics-reporter-config-sample.yaml
rm cqlshrc.sample

echo "Remove unwanted tools"
cd /opt/cassandra/tools/bin
rm *.bat


mkdir -p /opt/cassandra/logs
mkdir -p /opt/cassandra/data
mkdir -p /opt/cassandra/commitlog
mkdir -p /opt/cassandra/savedcaches



mkdir -p /etc/cassandra/
cp ~/resources/etc-cassie-jmxremote.password /etc/cassandra/jmxremote.password
chmod -r /etc/cassandra/jmxremote.password

cp ~/resources/opt/cassandra/conf/cassandra-yaml.template /opt/cassandra/conf/cassandra-yaml.template


cp ~/resources/start.sh /opt/cassandra/start.sh


echo "Create Unix Cassandra User"
useradd cassandra

echo "Chown files to cassandra"
chown -R cassandra /opt/cassandra
