#!/bin/bash

docker run --ipc host --gpus all -d -t --rm -v /home/ubuntu/GIT/candle_benchmarks:/workspace/candle_benchmarks \
        -v /home/ubuntu/GIT/power_monitor:/workspace/power_monitor candle_benchmarks