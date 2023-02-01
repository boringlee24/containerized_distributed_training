#!/bin/bash

CONTAINER_ID=$1
ARCH=$2

docker container exec -it $CONTAINER_ID python main.py -a $ARCH -b 64 imagenet