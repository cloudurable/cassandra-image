#!/bin/bash

## Remove constraint on processes
rm -f /etc/security/limits.d/*-nproc.conf
## Copy our limits.conf
cp ~/resources/limits.conf /etc/security/limits.conf
## Copy our sysctl.conf
cp  ~/resources/sysctl.conf /etc/sysctl.conf
## Disable huge pages which can cause a CPU spike.
cp ~/resources/initd-disable-transparent-hugepages /etc/init.d/disable-transparent-hugepages
chmod 755 /etc/init.d/disable-transparent-hugepages




