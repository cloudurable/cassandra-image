#!/bin/bash
set -e

source bin/ec2-env.sh

if [ -z "$1" ]
    then
        IP_ADDRESS=`bin/get-ip-ec2-instance.sh`
    else
        IP_ADDRESS=$(bin/get-ip-ec2-instance.sh $1)
fi


echo "IP ADDRESS $IP_ADDRESS"

if [ ! -f "$PEM_FILE" ]; then
    echo "Put your key file $PEM_FILE in your .ssh directory."
    exit 1
fi
ssh -i  "$PEM_FILE"  centos@${IP_ADDRESS}

