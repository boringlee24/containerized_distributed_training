#!/bin/bash
set -x 

CONTAINER_ID=$1
ARCH=$2 # see single_batch keys below
NUM_GPU=$3
GPU_TYPE=$4
DEVICE_IDS=$5 # e.g, 0,1 if 2 GPUs

declare -A single_batch

single_batch=( ["Combo/combo"]=64 ["NT3/nt3"]=2 ["P1B2/p1b2"]=64 ["ST1/sct"]=64 ["TC1/tc1"]=20)
# echo "${single_batch[$ARCH]}"
# echo $((NUM_GPU*single_batch[$ARCH]))

docker container exec -it $CONTAINER_ID /bin/bash -c "CUDA_VISIBLE_DEVICES=$DEVICE_IDS \
python ${ARCH}_baseline_keras2.py \
--batch_size $((NUM_GPU*single_batch[$ARCH])) --gpu-type $GPU_TYPE \
--num-gpu $NUM_GPU"