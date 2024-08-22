#!/bin/bash

# sending 'Q' to runtime will request it to exit gracefully (cleanup containers)
screen -S slruntime1 -X stuff 'Q'`echo -ne '\015'` 
while screen -list | grep -q slruntime1
do
    sleep 1
done
# still try to kill runner containers in case exit failed to cleanup correctly
echo "This many runners still alive (should be zero; will kill them if not): "`docker ps | grep slruntime-python-runner | wc -l`
(docker kill `docker ps | grep slruntime-python-runner | cut -d" " -f1` 2>&1) > /dev/null 

