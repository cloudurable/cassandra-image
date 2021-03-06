#!/bin/bash
set -e

source bin/ec2-env.sh


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
        SUBNET_PRIVATE="$SUBNET_PRIVATE1"
    else
        SUBNET_PRIVATE="$SUBNET_PRIVATE2"
fi

instance_id=$(aws ec2 run-instances --image-id "$CASSANDRA_AMI" --subnet-id  "$SUBNET_PRIVATE" \
 --instance-type ${CASSANDRA_NODE_SIZE} --private-ip-address ${PRIVATE_IP_ADDRESS}  \
 --iam-instance-profile "Name=$CASSANDRA_IAM_PROFILE" \
 --security-group-ids "$CASSANDRA_SECURITY_GROUP" \
 --user-data file://resources/user-data/cassandra \
 --key-name "$KEY_PAIR_NAME" | jq --raw-output .Instances[].InstanceId)

## For debugging only...
#  --associate-public-ip-address ADD this param to run-instances if you add Cassandra to pub subnet

echo "Cassandra Database: Cassandra Cluster Node ${instance_id} is being created"

aws ec2 wait instance-exists --instance-ids "$instance_id"

aws ec2 create-tags --resources "${instance_id}" --tags Key=Name,Value="${CASSANDRA_EC2_INSTANCE_NAME}" \
Key=Cluster,Value="Cassandra" Key=Role,Value="Cassandra_Database_Cluster_Node" Key=Env,Value="DEV"

echo "Cassandra Node ${instance_id} was tagged waiting for status ready"

aws ec2 wait instance-status-ok --instance-ids "$instance_id"

## For debugging only
## --associate-public-ip-address ADD this param to run-instances if you add Cassandra to pub subnet
# bin/associate-route53-DNS-with-IP.sh

