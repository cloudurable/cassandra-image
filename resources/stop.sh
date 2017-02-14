#!/bin/bash
set -e

export CASSANDRA_PID_PATH=/opt/cassandra/PID

if [  -f  "$CASSANDRA_PID_PATH" ]; then
    echo "PID file found"
    export CASSANDRA_PID=`cat "$CASSANDRA_PID_PATH"`
    # TODO
    # nodetool disablegossip, drain (when if ever should we run repair?, probably not here)
    sudo su cassandra -c "/bin/kill $CASSANDRA_PID" -s /bin/sh
fi