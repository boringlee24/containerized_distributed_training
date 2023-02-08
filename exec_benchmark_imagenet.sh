#!/bin/bash
set -x 

CONTAINER_ID=$1
ARCH=$2
NUM_GPU=$3
GPU_TYPE=$4
DEVICE_IDS=$5 # e.g, 0,1 if 2 GPUs

docker container exec -it $CONTAINER_ID /bin/bash -c "CUDA_VISIBLE_DEVICES=$DEVICE_IDS \
python main.py -a $ARCH \
-b $((NUM_GPU*64)) --benchmarking --gpu-type $GPU_TYPE \
--multiprocessing-distributed --world-size 1 --rank 0 \
--num-gpu $NUM_GPU imagenet"