#!/bin/bash
set -e


export REGION=us-west-2
export ENV=dev
export KEY_PAIR_NAME="cloudurable-$REGION"
export PEM_FILE="${HOME}/.ssh/${KEY_PAIR_NAME}.pem"
export SUBNET_PUBLIC=subnet-abc1234
export SUBNET_PRIVATE=subnet-abc1234
export CLOUD_FORMER_S3_BUCKET=abc1234-cloudformer-templates



export BASTION_NODE_SIZE=t2.small
export BASTION_SECURITY_GROUP=sg-abc1234
export BASTION_AMI=ami-abc1234
export BASTION_EC2_INSTANCE_NAME="bastion.${ENV}.${REGION}"
export BASTION_DNS_NAME="bastion.${ENV}.${REGION}.cloudurable.com."


export CASSANDRA_NODE_SIZE=m4.large
export CASSANDRA_AMI=ami-abc1234
export CASSANDRA_SECURITY_GROUP=sg-abc1234
export CASSANDRA_IAM_PROFILE=IAM_PROFILE_CASSANDRA
export CASSANDRA_EC2_INSTANCE_NAME="cassandra-node.${ENV}.${REGION}"
export CASSANDRA_DNS_NAME="node0.${ENV}.${REGION}.cloudurable.com."


export HOSTED_ZONE_ID="abc1234"


