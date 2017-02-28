#!/bin/bash

set -e

cp ~/resources/etc/systemd/system/cassandra.service /etc/systemd/system/cassandra.service
systemctl enable cassandra
systemctl start  cassandra


cp ~/resources/etc/systemd/system/metricsd.service /etc/systemd/system/metricsd.service
cp ~/resources/etc/metricsd.conf /etc/metricsd.conf
systemctl enable metricsd
systemctl start  metricsd

cp ~/resources/etc/systemd/system/systemd-cloud-watch.service /etc/systemd/system/systemd-cloud-watch.service
cp ~/resources/etc/systemd-cloud-watch.conf /etc/systemd-cloud-watch.conf
systemctl enable systemd-cloud-watch
systemctl start  systemd-cloud-watch


