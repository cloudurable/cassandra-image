#!/bin/bash
set -e

export AMI_CASSANDRA=ami-78ba3918
export VPC_SECURITY_GROUP=sg-a0b7e3d8

export SUBNET_CLUSTER=subnet-b30af4fa
export KEY_NAME_CASSANDRA=cloudurable
export PEM_FILE="${HOME}/.ssh/${KEY_NAME_CASSANDRA}.pem"
export IAM_PROFILE_CASSANDRA=IAM_PROFILE_CASSANDRA
export EC2_INSTANCE_NAME=cassandra-node


