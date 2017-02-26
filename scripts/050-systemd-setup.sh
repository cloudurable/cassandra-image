#!/bin/bash

set -e

cp ~/resources/etc/systemd/system/cassandra.service /etc/systemd/system/cassandra.service
systemctl enable cassandra
systemctl start  cassandra


cp ~/resources/etc/systemd/system/metricsd.service /etc/systemd/system/metricsd.service
systemctl enable metricsd
systemctl start  metricsd

cp ~/resources/etc/systemd/system/systemd-cloud-watch.service /etc/systemd/system/systemd-cloud-watch.service
systemctl enable systemd-cloud-watch
systemctl start  systemd-cloud-watch


