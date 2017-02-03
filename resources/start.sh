#!/bin/bash
set -e

if [ "x$DOCKER" = "x" ]; then
    DOCKER=false
fi

if [ "$DOCKER" = "false" ]; then
    sudo swapoff -a
fi

export LOCAL_JMX=no

sudo su cassandra -c "/opt/cassandra/bin/cassandra" -s /bin/sh

