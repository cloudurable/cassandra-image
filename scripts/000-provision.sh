#!/bin/bash
set -e

yum install -y wget
yum install -y nano
yum install -y java-1.8.0-openjdk
yum install -y ntp
yum install -y jna

yum install -y epel-release
yum install -y jemalloc
yum install -y net-tools

