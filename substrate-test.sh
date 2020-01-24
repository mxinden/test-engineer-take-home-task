#!/bin/bash

RESULT_BLOCK_HEADER_NUMBER="0"
OLD_VALUE="-1"

docker stop `docker ps -q` > /dev/null 2>&1
