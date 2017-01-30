#!/bin/bash
set -e
docker run  -it -p 17000:7000 -p 27199:7199 -p 29042:9042 -e DOCKER=true -e HOST_IP=`ipconfig getifaddr en0` \
-e PARENT_HOST_NAME=`hostname` --name cassie  cloudurable/cassandra:0.6.0
