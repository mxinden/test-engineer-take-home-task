#!/bin/bash

# Containes number block in hex format without 0x
RESULT_BLOCK_HEADER_NUMBER="0"
# Comparing this value with the previous one lets avoid to print duplicated block
OLD_VALUE="-1"

# Runnign containers stopped to avoid any mistake
docker stop `docker ps -q` > /dev/null 2>&1

# parity/substrate:2.0.0-31c633c47
# script input which is the image that we are going to run
docker run -itd  $1 --dev > /dev/null 2>&1
# Container id will be used in docker command
CONTAINER_ID=$(docker ps -q)

# in this loop we check number of block not to exceed from 10(a) and also print the output, 0 for success and error code for problematic
while [ "$RESULT_BLOCK_HEADER_NUMBER" != "a" ]
  do
    # block number in hex format extracted
    TEMP_VAR=$(docker exec -it $CONTAINER_ID curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "chain_getBlock"}' localhost:9933 |jq .result.block.header.number)
    # check whether block generated or not
    if [ $? == 0 ]
      then          
          # 0x removed from hex format
          RESULT_BLOCK_HEADER_NUMBER="$(echo $TEMP_VAR | awk -F \" '{print $2}' | awk -F 0x '{print $2}')"
          # following if helps to avoid duplicated data to print
          if [ "$OLD_VALUE" != "$RESULT_BLOCK_HEADER_NUMBER" ]
            then
                echo "---"
                echo 0x$RESULT_BLOCK_HEADER_NUMBER
                echo "0"
                echo "+++"
          fi
      else
          RESULT_BLOCK_HEADER_NUMBER="$(echo $TEMP_VAR | awk -F \" '{print $2}' | awk -F 0x '{print $2}')"
          echo "Error"          
          echo 0x$RESULT_BLOCK_HEADER_NUMBER
          echo $?
          echo "Error"
    fi

    # Comparing this variable with other one, helps us to know whether new block genrated or not      
    OLD_VALUE=$RESULT_BLOCK_HEADER_NUMBER
    #echo 0x$RESULT_BLOCK_HEADER_NUMBER
done

# At the end, container stop
docker stop $CONTAINER_ID > /dev/null 2>&1
