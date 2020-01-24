#!/bin/bash

RESULT_BLOCK_HEADER_NUMBER="0"
OLD_VALUE="-1"

docker stop `docker ps -q` > /dev/null 2>&1

# parity/substrate:2.0.0-31c633c47
docker run -itd  $1 --dev > /dev/null 2>&1
CONTAINER_ID=$(docker ps -q)
