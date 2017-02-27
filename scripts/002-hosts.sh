#!/bin/bash
set -e

## Copy keys to servers.
mkdir  -p  ~/.ssh/
cp ~/resources/server/certs/*  ~/.ssh/

## Copy csqlshrc file that controls csqlsh connections to ~/.cassandra/cqlshrc.
mkdir ~/.cassandra
cp ~/resources/home/.cassandra/cqlshrc ~/.cassandra/cqlshrc

## Allow password login to ssh.
# sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -ie 's/#PubkeyAuthentication no/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

## System control restart sshd daemon to take sshd_config into effect.
systemctl restart sshd

# Create host file so it is easier to ssh from box to box
cat >> /etc/hosts <<EOL

192.168.50.20  bastion

192.168.50.4  node0
192.168.50.5  node1
192.168.50.6  node2
192.168.50.7  node3
192.168.50.8  node4
192.168.50.9  node5
EOL