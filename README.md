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

