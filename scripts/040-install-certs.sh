#!/bin/bash

set -e

DESTINATION_DIRECTORY=/opt/cassandra/conf/certs
SOURCE_DIRECTORY="~/resources$DESTINATION_DIRECTORY"

if [ -d "$SOURCE_DIRECTORY" ]; then
    mkdir -p "$DESTINATION_DIRECTORY"

    cp -r "$SOURCE_DIRECTORY" "$DESTINATION_DIRECTORY"
fi


if [ ! -d "$SOURCE_DIRECTORY" ]; then
    echo "UNABLE TO INSTALL CERTS AS THEY WERE NOT FOUND"
fi