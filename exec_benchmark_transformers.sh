#!/bin/bash

CONTAINER_ID=$1
ARCH=$2

docker container exec -it $CONTAINER_ID python3 run_qa_no_trainer.py --model_name_or_path $ARCH --dataset_name squad --max_seq_length 384 --doc_stride 128 --output_dir ~/tmp/debug_squad