#!/bin/bash
set -e
docker run  -it -p 17000:7000 -p 17199:7199 -p 19042:9042 -e DOCKER=true --name cassie  cloudurable/cassandra:0.4.4
