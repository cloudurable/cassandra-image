#!/bin/bash
set -e

# Create Bastion Node for Oregon/us-west-2
bin/create-ec2-instance-bastion.sh us-west-2

# Create Cassandra Nodes for Oregon/us-west-2
bin/create-ec2-instance-cassandra.sh 10.1.1.10 a us-west-2
bin/create-ec2-instance-cassandra.sh 10.1.2.10 b us-west-2
bin/create-ec2-instance-cassandra.sh 10.1.1.11 a us-west-2
bin/create-ec2-instance-cassandra.sh 10.1.2.11 b us-west-2

