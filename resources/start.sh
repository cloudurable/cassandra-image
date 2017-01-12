#!/bin/bash
set -e

if [ "x$DOCKER" = "x" ]; then
    DOCKER=false
fi

if [ "$DOCKER" = "false" ]; then
    sudo swapoff -a
fi

export LOCAL_JMX=no
/opt/cassandra/bin/cassandra
