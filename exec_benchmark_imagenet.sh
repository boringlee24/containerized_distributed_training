#!/bin/bash
set -x 

CONTAINER_ID=$1
ARCH=$2
NUM_GPU=$3

docker container exec -it $CONTAINER_ID python main.py -a $ARCH -b $((NUM_GPU*32)) imagenet