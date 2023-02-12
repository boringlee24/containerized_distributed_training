#!/bin/sh
set -x

./exec_benchmark_imagenet.sh $1 resnet50 $2 nvidia $3 \
./exec_benchmark_imagenet.sh $1 bit_b_16 $2 nvidia $3
