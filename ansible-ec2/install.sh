#!/usr/bin/env bash

if [ ! -d "ansible-ec2/ec2.py" ]; then
    wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py -O ansible-ec2/ec2.py
    chmod +x ansible-ec2/ec2.py
    sudo cp ansible-ec2/ec2.py /etc/ansible/ec2.py
    wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini -O ansible-ec2/ec2.ini
    sudo cp ansible-ec2/ec2.ini /etc/ansible/ec2.ini
fi

export ANSIBLE_HOSTS=/etc/ansible/ec2.py
export EC2_INI_PATH=/etc/ansible/ec2.ini


echo export ANSIBLE_HOSTS="$PWD/ansible-ec2/ec2.py"
echo export EC2_INI_PATH="$PWD/ansible-ec2/ec2.ini"
echo source bin/ec2-env.sh

#
echo "Things to try"
echo "Show all names in the dynamic EC2 inventory"
echo "ansible-ec2/ec2.py --list"
echo "Start up a new agent and load the identity"
echo "ssh-agent bash"
echo  "ssh-add $PEM_FILE"
echo "Use ansible to ping EC2 instance named cassandra_node"
echo  ansible -m ping tag_Name_cassandra_node
