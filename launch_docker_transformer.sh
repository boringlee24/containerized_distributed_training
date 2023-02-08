#!/bin/bash

#### training imagenet ####

# launch pytorch docker

docker run --ipc host --gpus all -d -t --rm -v /home/ubuntu/GIT/transformers:/workspace/transformers \
        -v /home/ubuntu/.cache/huggingface:/root/.cache/huggingface \
        -v /home/ubuntu/GIT/power_monitor:/workspace/power_monitor transformer_benchmarks