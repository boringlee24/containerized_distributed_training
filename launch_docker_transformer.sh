#!/bin/bash

#### training imagenet ####

# launch pytorch docker

docker run --ipc host --gpus all -it --rm -v /home/ubuntu/GIT/transformers:/workspace/transformers nvcr.io/nvidia/pytorch:22.12-py3