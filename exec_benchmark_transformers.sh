#!/bin/bash

CONTAINER_ID=$1
ARCH=$2
NUM_GPU=$3

if (($NUM_GPU > 1)); then
        echo "${NUM_GPU}-GPU run"
        python3 set_num_gpu.py --num_gpu $NUM_GPU && sleep 1
        docker container exec -it $CONTAINER_ID accelerate launch run_qa_no_trainer.py --model_name_or_path $ARCH \
                --dataset_name squad --max_seq_length 384 --doc_stride 128
else
        echo "Single-GPU run"
        docker container exec -it $CONTAINER_ID python3 run_qa_no_trainer.py --model_name_or_path $ARCH \
                --dataset_name squad --max_seq_length 384 --doc_stride 128
fi

