#!/bin/bash
set -e

source bin/ec2-env.sh

instance_id=$(aws ec2 run-instances --image-id "$AMI_CASSANDRA" --subnet-id  "$SUBNET_CLUSTER" \
 --instance-type m4.large --iam-instance-profile "Name=$IAM_PROFILE_CASSANDRA" \
 --associate-public-ip-address --security-group-ids "$VPC_SECURITY_GROUP" \
 --key-name "$KEY_NAME_CASSANDRA" | jq --raw-output .Instances[].InstanceId)

echo "${instance_id} is being created"

aws ec2 wait instance-exists --instance-ids "$instance_id"

aws ec2 create-tags --resources "${instance_id}" --tags Key=Name,Value="${EC2_INSTANCE_NAME}"

echo "${instance_id} was tagged waiting to login"

aws ec2 wait instance-status-ok --instance-ids "$instance_id"

bin/login-ec2-cassandra.sh


