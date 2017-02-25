#!/bin/bash

DESTINATION_DIRECTORY=/opt/cassandra/conf/certs
cd ~
SOURCE_DIRECTORY="$PWD/resources$DESTINATION_DIRECTORY"

echo $SOURCE_DIRECTORY


if [ -d "$SOURCE_DIRECTORY" ]; then

    echo "$SOURCE_DIRECTORY was found making directory $DESTINATION_DIRECTORY"

    mkdir -p "$DESTINATION_DIRECTORY"

    echo "$SOURCE_DIRECTORY was found"

    cp  "${SOURCE_DIRECTORY}"/*  "$DESTINATION_DIRECTORY"
fi


if [ ! -d "$SOURCE_DIRECTORY" ]; then
    echo "UNABLE TO INSTALL CERTS AS THEY WERE NOT FOUND"
fi
