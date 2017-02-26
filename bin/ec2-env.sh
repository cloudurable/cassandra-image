#!/bin/bash
set -e

export AMI_CASSANDRA=ami-78ba3918
export VPC_SECURITY_GROUP=sg-a86533d0

export SUBNET_CLUSTER=subnet-dc0f2984
export KEY_NAME_CASSANDRA=cloudurable-us-west-2
export PEM_FILE="${HOME}/.ssh/${KEY_NAME_CASSANDRA}.pem"
export IAM_PROFILE_CASSANDRA=IAM_PROFILE_CASSANDRA
export EC2_INSTANCE_NAME=cassandra-node


