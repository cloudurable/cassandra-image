#!/bin/bash

set -e

cp ~/resources/etc/systemd/system/cassandra.service /etc/systemd/system/cassandra.service
systemctl enable cassandra
systemctl start  cassandra
