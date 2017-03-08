#!/bin/bash
set -e

# Create Bastion for Ohio/us-east-2
bin/create-ec2-instance-bastion.sh us-east-2


# Create Cassandra nodes for Ohio/us-east-2
bin/create-ec2-instance-cassandra.sh 10.2.1.10 a us-east-2
bin/create-ec2-instance-cassandra.sh 10.2.2.10 b us-east-2
bin/create-ec2-instance-cassandra.sh 10.2.1.11 a us-east-2
bin/create-ec2-instance-cassandra.sh 10.2.2.11 b us-east-2



