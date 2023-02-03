# Instructions to set up containerized distributed training

## Launch AWS machine

Log into the AWS console, go to Ohio region, EC2, on the left tab, select **AMIs** under Images.

Right click ''benchmarks'', and launch instances from AMI. Under **Instance type**, use ```g4dn.xlarge``` for debugging, or any other instance type you want to run.

Create a key pair if you did not create one before, you will use your ''<yourkeypairname>.pem'' key (RSA type) for connecting to the EC2 instance. Save the ''.pem'' key on your local machine.

Select existing security group ```grpc-all-tcp```. Then go to the end and click launch instance.

Go to **Instances**, right click the instance you just created and **connect**. Use an ssh client to connect to it. Copy the command

```
ssh -i "<yourkeypairname>.pem" ubuntu@ec2-xxx.us-east-2.compute.amazonaws.com
```
and run it on your local machine. Make sure "<yourkeypairname>.pem" is a path that points to your key. If you connect from an IDE, the .ssh configure file also need to specify the path to your .pem key. Here is an example of how I configured my .ssh config file
```
Host aws-ec2
  HostName ec2-xxx.us-east-2.compute.amazonaws.com
  IdentityFile "C:\Users\xxx\.ssh\xxx.pem"
  User ubuntu
```


## Launch benchmark from docker container

When you are eonnected to the EC2 machine, navigate to this repo. Make sure it's the latest version. Also make sure the other repos in the ```GIT``` directory are the latest versions. Then run 

```
./launch_docker_<benchmark>.sh
```

Use ```docker container ls``` to check if the container is up. Once it's up, grab the container ID and run

```
./exec_benchmark_<benchmark>.sh <arg1> <arg2> ...
```
You can also execute the command in shell inside a container (good for debug purposes). Run this command:
```
docker container exec -it <container ID> /bin/bash
```

For imagenet benchmarks, try these models: ```resnet50```, ```vit_b_16```, ```vgg19_bn```, ```resnext50_32x4d```, ```inception_v3```, ```shufflenet_v2_x1_5```.

For transformer benchmarks, try these models: ```bert-base-uncased```, ```xlnet-base-cased```, ```xlm-mlm-en-2048```, ```roberta-base```, ```distilbert-base-cased```.



## Exit

When you have finished the benchmarking, stop the container:
```
docker stop <container ID>
```
On AWS EC2 console, stop or terminate the instance.

# Introduction to running the benchmarks on discovery

The P100 and V100 GPU experiments can be run on discovery cluster. 

## Allocate a node

```
srun --pty --export=ALL --partition multigpu --tasks-per-node 1 --nodes 1 --mem=100G --time=10:00:00 --gres=gpu:<gpu type>:4 --cpus-per-task=16 /bin/bash
```

The \<gpu type\> will be ```v100-sxm2``` if using V100 GPU, and ```p100``` if using P100 GPU.

## Set up discovery environment (only needed for the first time)

###Load CUDA driver
```
module load cuda/11.3
```
Put this command in your ```~/.bashrc``` so you don't need to load cuda every time.

###Anaconda
First install Anaconda on discovery. The installation instructions are here: https://docs.anaconda.com/anaconda/install/linux/

Install the conda environment from the .yml file
```
conda env create -f benchmark.yml
```

Activate the conda environment. 
```
source activate pytorch1.10
```
Put this into your ```~/.bashrc``` file so that you don't need to activate it every time.

## Run the benchmarks

Follow the instructions in ```exec_benchmark_<name>.sh``` file, but without docker. Go to the corresponding benchmark directory and run the script. For transformer models, you need to first run 
```
accelerate config
```
Answer the questionaire according to this example.
```
compute_environment: LOCAL_MACHINE
deepspeed_config: {}
distributed_type: MULTI_GPU
downcast_bf16: 'no'
dynamo_backend: 'NO'
fsdp_config: {}
gpu_ids: all
machine_rank: 0
main_training_function: main
megatron_lm_config: {}
mixed_precision: 'no'
num_machines: 1
num_processes: 4
rdzv_backend: static
same_network: true
use_cpu: false
```
You will find your generated file at ```~/.cache/huggingface/accelerate/default_config.yaml```. Only re-run ```accelerate config``` when the number of GPUs change (the num_processes entry in the example). Again this is only applicable to the transformer benchmark.

## Exit

Just exit the node. You can see if you have any allocations active using
```
squeue -u $USER
```
