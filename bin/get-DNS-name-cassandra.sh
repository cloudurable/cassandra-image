#!/bin/bash
set -e

source bin/ec2-env.sh

aws ec2 describe-instances --filters  "Name=tag:Name,Values=${EC2_INSTANCE_NAME}" \
| jq --raw-output .Reservations[].Instances[].PublicDnsName

