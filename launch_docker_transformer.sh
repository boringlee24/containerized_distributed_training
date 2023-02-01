#!/bin/bash

#### training imagenet ####

# launch pytorch docker

docker run --ipc host --gpus all -it --rm -v /home/ubuntu/GIT/transformers:/workspace/transformers \
        -v /home/ubuntu/.cache/huggingface:/root/.cache/huggingface transformer_benchmarks