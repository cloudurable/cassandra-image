#!/bin/bash
set -e

source bin/ec2-env.sh

if [ "$1" == "-h" ]
    then
        echo "Usage:"
        echo "bin/get-ip-ec2-instance.sh  <EC2_INSTANCE_NAME|Optional> <AWS_REGION|Optional>"
        echo "Example:"
        echo "bin/get-ip-ec2-instance cassandra.node.0 us-east-2"
        exit 0
fi


if [ -z "$1" ]
    then
        EC2_INSTANCE_NAME="$CASSANDRA_EC2_INSTANCE_NAME"
    else
        EC2_INSTANCE_NAME="$1"
fi

# Set aws-region
if [ -z "$2" ]
    then
        AWS_REGION=${REGION}
    else
        AWS_REGION=$2
fi



aws --region "$AWS_REGION"  ec2 describe-instances --filters  "Name=tag:Name,Values=${EC2_INSTANCE_NAME}" \
"Name=instance-state-name,Values=running" \
| jq --raw-output .Reservations[].Instances[0].PublicIpAddress