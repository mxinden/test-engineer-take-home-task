#!/bin/bash

RESULT_BLOCK_HEADER_NUMBER="0"
OLD_VALUE="-1"

docker stop `docker ps -q` > /dev/null 2>&1

# parity/substrate:2.0.0-31c633c47
docker run -itd  $1 --dev > /dev/null 2>&1
CONTAINER_ID=$(docker ps -q)

while [ "$RESULT_BLOCK_HEADER_NUMBER" != "a" ]
  do
    TEMP_VAR=$(docker exec -it $CONTAINER_ID curl -H "Content-Type: application/json" -d '{"id":1, "jsonrpc":"2.0", "method": "chain_getBlock"}' localhost:9933 |jq .result.block.header.number)
    if [ $? == 0 ]
      then          
          RESULT_BLOCK_HEADER_NUMBER="$(echo $TEMP_VAR | awk -F \" '{print $2}' | awk -F 0x '{print $2}')"
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
      
    OLD_VALUE=$RESULT_BLOCK_HEADER_NUMBER
    #echo 0x$RESULT_BLOCK_HEADER_NUMBER
done
