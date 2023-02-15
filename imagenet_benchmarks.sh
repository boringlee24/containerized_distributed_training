#!/bin/sh

./exec_benchmark_imagenet.sh $1 resnet50 $2 $3 $4 \
./exec_benchmark_imagenet.sh $1 vit_b_16 $2 $3 $4 \
./exec_benchmark_imagenet.sh $1 vgg19_bn $2 $3 $4 \
./exec_benchmark_imagenet.sh $1 resnext50_32x4d $2 $3 $4 \
./exec_benchmark_imagenet.sh $1 inception_v3 $2 $3 $4 \
./exec_benchmark_imagenet.sh $1 shufflenet_v2_x1_5 $2 $3 $4 
