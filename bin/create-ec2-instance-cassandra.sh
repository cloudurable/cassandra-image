#!/bin/bash
set -e

source bin/ec2-env.sh

if [ "$1" == "-h" ]
    then
        echo "Usage:"
        echo "bin/create-ec2-instance-cassandra.sh <PRIVATE_IP_ADDRESS|Optional> <AZ|Optional> <AWS_REGION|Optional>"
        echo "Example:"
        echo "bin/create-ec2-instance-cassandra.sh 10.0.1.10 a us-east-2"
        exit 0
fi

# Set aws-region
if [ -z "$3" ]
    then
        export AWS_REGION=${REGION}
    else
        export AWS_REGION=$3
fi

source bin/ec2-env-region.sh


# Set the private IP to 10.0.1.10 (the seed node), if first arg empty
if [ -z "$1" ]
    then
        PRIVATE_IP_ADDRESS=10.0.1.10
    else
        PRIVATE_IP_ADDRESS=$1
fi

# Set the AZ to a if empty
if [ -z "$2" ]
    then
        AZ="a"
    else
        AZ=$2
fi

if [ "$AZ" == "a" ]
    then
        echo "SETTING SUBNET TO $SUBNET_PRIVATE1"
        SUBNET_PRIVATE="$SUBNET_PRIVATE1"
    else
        echo "SETTING SUBNET TO $SUBNET_PRIVATE2"
        SUBNET_PRIVATE="$SUBNET_PRIVATE2"
fi


export CASSANDRA_EC2_INSTANCE_NAME="cassandra-node.${ENV}.${AWS_REGION}"


echo "Calling with args aws region = $AWS_REGION, private IP = $PRIVATE_IP_ADDRESS, AZ = $AZ, $SUBNET_PRIVATE "


instance_id=$(aws --region ${AWS_REGION} ec2 run-instances --image-id "$CASSANDRA_AMI" --subnet-id  "$SUBNET_PRIVATE" \
 --instance-type ${CASSANDRA_NODE_SIZE} --private-ip-address ${PRIVATE_IP_ADDRESS}  \
 --iam-instance-profile "Name=$CASSANDRA_IAM_PROFILE" \
 --security-group-ids "$CASSANDRA_SECURITY_GROUP" \
 --user-data file://resources/user-data/cassandra | jq --raw-output .Instances[].InstanceId)

## For debugging only...
#  --associate-public-ip-address ADD this param to run-instances if you add Cassandra to pub subnet

echo "Cassandra Database: Cassandra Cluster Node ${instance_id} is being created"

aws --region ${AWS_REGION} ec2 wait instance-exists --instance-ids "$instance_id"

aws --region ${AWS_REGION} ec2 create-tags --resources "${instance_id}" \
--tags Key=Name,Value="${CASSANDRA_EC2_INSTANCE_NAME}" Key=Cluster,Value="Cassandra" \
Key=Role,Value="Cassandra_Database_Cluster_Node" Key=Env,Value="DEV"

echo "Cassandra Node ${instance_id} was tagged waiting for status ready"

aws --region ${AWS_REGION} ec2 wait instance-status-ok --instance-ids "$instance_id"

## For debugging only
## --associate-public-ip-address ADD this param to run-instances if you add Cassandra to pub subnet
# bin/associate-route53-DNS-with-IP.sh

