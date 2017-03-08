#!/bin/bash
set -e

# Create Cassandra seed nodes in AWS AZ a and AWS AZ b.
bin/create-ec2-instance-cassandra.sh 10.0.1.10 a
bin/create-ec2-instance-cassandra.sh 10.0.2.10 b


# Create two more Cassandra database servers in AZ a and b.
bin/create-ec2-instance-cassandra.sh 10.0.1.11 a
bin/create-ec2-instance-cassandra.sh 10.0.2.11 b

