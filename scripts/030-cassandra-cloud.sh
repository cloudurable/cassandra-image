#!/bin/bash

set -e

mkdir -p /tmp/cassandra-cloud-install
cd /tmp/cassandra-cloud-install

wget https://github.com/cloudurable/cassandra-cloud/releases/download/v0.0.3/cassandra-cloud
mv cassandra-cloud /opt/cassandra/bin/cassandra-cloud
chmod +x /opt/cassandra/bin/cassandra-cloud

rm  -rf /tmp/cassandra-cloud-install

echo "Done"
