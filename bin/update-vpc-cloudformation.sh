#!/usr/bin/env bash
set -e

source bin/ec2-env.sh

# Set aws-region
if [ -z "$1" ]
    then
        AWS_REGION=${REGION}
    else
        AWS_REGION=$1
fi

source bin/ec2-env-region.sh

aws --region ${REGION} s3 cp cloud-formation/vpc.json s3://$CLOUD_FORMER_S3_BUCKET
aws --region ${AWS_REGION} cloudformation update-stack --stack-name ${ENV}-vpc-cassandra \
--template-url "https://s3-us-west-2.amazonaws.com/$CLOUD_FORMER_S3_BUCKET/vpc.json" \
--parameters ParameterKey=vpcCidr,ParameterValue=${SUBNET_VPC_CIDR} \
    ParameterKey=subnetPublicCidr,ParameterValue=${SUBNET_PUBLIC_CIDR} \
    ParameterKey=subnetCluster1Cidr,ParameterValue=${SUBNET_CLUSTER1_CIDR} \
    ParameterKey=subnetCluster2Cidr,ParameterValue=${SUBNET_CLUSTER2_CIDR}