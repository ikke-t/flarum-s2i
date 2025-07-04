#!/bin/bash

# VALID_ARGS=$(getopt -o w:q:s: --long worker-type:,queue-memory:,queue-sleep:,queue-tries: -- "$@")
VALID_ARGS=$(getopt -o w: --long worker-type: -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi

eval set -- "$VALID_ARGS"
ARG_WORKER_TYPE=""
# ARG_QUEUE_MEMORY=256
# ARG_QUEUE_SLEEP=10
# ARG_QUEUE_TRIES=3

while [ : ]; do
  case "$1" in
    -w | --worker-type)
        ARG_WORKER_TYPE=$2
        echo "argument 'worker-type' set to '$ARG_WORKER_TYPE'"
        shift 2
        ;;
    # -m | --queue-memory)
    #     ARG_QUEUE_MEMORY=$2
    #     echo "argument 'queue-memory' set to '$ARG_QUEUE_MEMORY'"
    #     shift 2
    #     ;;
    # -s | --queue-sleep)
    #     ARG_QUEUE_SLEEP=$2
    #     echo "argument 'queue-sleep' set to '$ARG_QUEUE_SLEEP'"
    #     shift 2
    #     ;;
    # -t | --queue-tries)
    #     ARG_QUEUE_TRIES=$2
    #     echo "argument 'queue-tries' set to '$ARG_QUEUE_TRIES'"
    #     shift 2
    #     ;;
    --) shift; 
        break 
        ;;
  esac
done


case "$ARG_WORKER_TYPE" in
    flarum)
        echo "starting flarum"
        /usr/libexec/s2i/run
        ;;
    scheduler)
        echo "starting flarum scheduler via supercronic"
        /opt/app-root/src/supercronic /opt/app-root/src/scheduler.cron
        ;;
    *)
        echo "worker type must be set"
        sleep 10
        exit 1
    break 
    ;;
esac
