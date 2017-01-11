#!/bin/bash
set -e
docker rm cassie
docker run  -it -p 7000:17000 -p 7199:17199 -p 9042:19042 --name cassie  cloudurable/cassandra:0.4
