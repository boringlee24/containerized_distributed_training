#!/bin/bash

#### training imagenet ####

# launch pytorch docker

docker run --ipc host --gpus all -d -t --rm \
        -v /home/ubuntu/GIT/examples/imagenet:/workspace/imagenet \
        -v /home/ubuntu/GIT/power_monitor:/workspace/power_monitor \
        imagenet_benchmarks