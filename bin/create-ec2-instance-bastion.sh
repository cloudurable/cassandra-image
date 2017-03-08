#!/bin/bash
set -e

source bin/ec2-env.sh

if [ "$1" == "-h" ]
    then
        echo "Usage:"
        echo "    bin/create-ec2-instance-bastion.sh <AWS_REGION|Optional>"
        echo "Example:"
        echo "    $ bin/create-ec2-instance-bastion.sh us-east-2"
        exit 0
fi

# Set aws-region
if [ -z "$1" ]
    then
        export AWS_REGION=${REGION}
    else
        export AWS_REGION=$1
fi

source bin/ec2-env-region.sh

BASTION_EC2_INSTANCE_NAME="bastion.${ENV}.${AWS_REGION}"
BASTION_DNS_NAME="bastion.${ENV}.${AWS_REGION}.cloudurable.com."

instance_id=$(aws --region ${AWS_REGION} ec2 run-instances --image-id "$BASTION_AMI" --subnet-id  "$SUBNET_PUBLIC" \
 --instance-type "$BASTION_NODE_SIZE" --iam-instance-profile "Name=$CASSANDRA_IAM_PROFILE" \
 --associate-public-ip-address --security-group-ids "$BASTION_SECURITY_GROUP" | jq --raw-output .Instances[].InstanceId)

echo "bastion ${instance_id} is being created"

aws --region ${AWS_REGION} ec2 wait instance-exists --instance-ids "$instance_id"

echo "Tagging instance"
aws --region ${AWS_REGION} ec2 create-tags --resources "${instance_id}" --tags Key=Name,Value="${BASTION_EC2_INSTANCE_NAME}" \
Key=Role,Value="Bastion" Key=Env,Value="DEV"

echo "${instance_id} was tagged waiting to login"

aws --region ${AWS_REGION} ec2 wait instance-status-ok --instance-ids "$instance_id"

echo "Associate DNS"
bin/associate-route53-DNS-with-IP.sh ${BASTION_EC2_INSTANCE_NAME} ${BASTION_DNS_NAME} ${AWS_REGION}



