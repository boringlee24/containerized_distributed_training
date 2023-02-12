#!/bin/bash
set -x

CONTAINER_ID=$1
NUM_GPU=$2
DEVICE_IDS=$3

./exec_benchmark_imagenet.sh $CONTAINER_ID resnet50 $NUM_GPU nvidia $DEVICE_IDS \
./exec_benchmark_imagenet.sh $CONTAINER_ID bit_b_16 $NUM_GPU nvidia $DEVICE_IDS
