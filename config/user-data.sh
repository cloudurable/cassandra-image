#!/bin/bash

## Used for EC2 AMI creation. 
sed -i -e '/Defaults    requiretty/{ s/.*/# Defaults    requiretty/ }' /etc/sudoers
sed -i -e '/%wheel\tALL=(ALL)\tALL/{ s/.*/%wheel\tALL=(ALL)\tNOPASSWD:\tALL/ }' /etc/sudoers
