#!/bin/bash
set -e

source bin/ec2-env.sh

if [ ! -f "$PEM_FILE" ]; then
    echo "Put your key file $PEM_FILE in your .ssh directory."
    exit 1
fi
ssh -i  "$PEM_FILE"  centos@`bin/get-IP-cassandra.sh`

