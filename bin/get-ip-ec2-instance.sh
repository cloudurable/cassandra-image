#!/bin/bash
set -e

source bin/ec2-env.sh

if [ -z "$1" ]
    then
        EC2_INSTANCE_NAME="$CASSANDRA_EC2_INSTANCE_NAME"
    else
        EC2_INSTANCE_NAME="$1"
fi


aws ec2 describe-instances --filters  "Name=tag:Name,Values=${EC2_INSTANCE_NAME}" \
"Name=instance-state-name,Values=running" \
| jq --raw-output .Reservations[].Instances[0].PublicIpAddress