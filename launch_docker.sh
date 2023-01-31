#!/bin/bash

#### training imagenet ####

# launch pytorch docker

docker run --ipc host --gpus all -d -t --rm -v /home/ubuntu/GIT/examples/imagenet:/workspace/imagenet imagenet_benchmarks