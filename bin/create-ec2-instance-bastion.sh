#!/bin/bash
set -e

source bin/ec2-env.sh

instance_id=$(aws ec2 run-instances --image-id "$BASTION_AMI" --subnet-id  "$SUBNET_PUBLIC" \
 --instance-type "$BASTION_NODE_SIZE" --iam-instance-profile "Name=$CASSANDRA_IAM_PROFILE" \
 --associate-public-ip-address --security-group-ids "$BASTION_SECURITY_GROUP" \
 --key-name "$KEY_PAIR_NAME" | jq --raw-output .Instances[].InstanceId)

echo "bastion ${instance_id} is being created"

aws ec2 wait instance-exists --instance-ids "$instance_id"

aws ec2 create-tags --resources "${instance_id}" --tags Key=Name,Value="${BASTION_EC2_INSTANCE_NAME}" \
Key=Role,Value="Bastion" Key=Env,Value="DEV"

echo "${instance_id} was tagged waiting to login"

aws ec2 wait instance-status-ok --instance-ids "$instance_id"


bin/associate-route53-DNS-with-IP.sh ${BASTION_EC2_INSTANCE_NAME} ${BASTION_DNS_NAME}
bin/login-ec2-instance.sh ${BASTION_EC2_INSTANCE_NAME}


