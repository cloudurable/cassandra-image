#!/bin/bash
set -e


export LOCAL_JMX=no

if [ "x$DOCKER" = "x" ]; then
    DOCKER=false
fi

if [ "$DOCKER" = "false" ]; then

    sudo swapoff -a
    sudo chown -R cassandra /opt/cassandra
    echo "RUNNING CASSANDRA"
    sudo su cassandra -c "/opt/cassandra/bin/cassandra -p /opt/cassandra/PID" -s /bin/sh
fi


if [ "$DOCKER" = "true" ]; then
    echo "RUNNING CASSANDRA AS ROOT"
    /opt/cassandra/bin/cassandra -R
fi

