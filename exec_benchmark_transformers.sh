#!/bin/bash
set -x 

CONTAINER_ID=$1
ARCH=$2
NUM_GPU=$3
GPU_TYPE=$4
GPU_IDS=$5 # e.g, 0,1 if 2 GPUs

if (($NUM_GPU > 1)); then
        echo "${NUM_GPU}-GPU run"
        python3 set_num_gpu.py --num_gpu $NUM_GPU && sleep 1
        docker container exec -it $CONTAINER_ID /bin/bash -c "CUDA_VISIBLE_DEVICES=$GPU_IDS \
        accelerate launch run_qa_no_trainer.py --model_name_or_path $ARCH \
        --dataset_name squad --max_seq_length 384 --doc_stride 128 --benchmarking \
        --gpu-type $GPU_TYPE --num-gpu $NUM_GPU"
else
        echo "Single-GPU run"
        docker container exec -it $CONTAINER_ID python3 run_qa_no_trainer.py --model_name_or_path $ARCH \
                --dataset_name squad --max_seq_length 384 --doc_stride 128
fi

