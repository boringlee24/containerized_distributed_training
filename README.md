# Instructions to set up containerized distributed training

## Launch AWS machine

Log into the AWS console, go to Ohio region, EC2, on the left tab, select **AMIs** under Images.

Right click ''benchmarks'', and launch instances from AMI. Under **Instance type**, use ```g4dn.xlarge``` for debugging, or any other instance type you want to run.

Create a key pair if you did not create one before, you will use your ''<yourkeypairname>.pem'' key (RSA type) for connecting to the EC2 instance. Save the ''.pem'' key on your local machine.

Select existing security group ```grpc-all-tcp```. Then go to the end and click launch instance.

Go to **Instances**, right click the instance you just created and **connect**. Use an ssh client to connect to it. Copy the command

```
ssh -i "<yourkeypairname>.pem" root@ec2-xxx.us-east-2.compute.amazonaws.com
```
and run it on your local machine. Make sure "<yourkeypairname>.pem" is a path that points to your key. If you connect from an IDE, the .ssh configure file also need to specify the path to your .pem key.


## Launch benchmark from docker container

When you are eonnected to the EC2 machine, navigate to this repo. Make sure it's the latest version. Also make sure the other repos in the ```GIT``` directory are the latest versions. Then run 

```
./launch_docker_<benchmark>.sh
```

Use ```docker container ls``` to check if the container is up. Once it's up, grab the container ID and run

```
./exec_benchmark_<benchmark>.sh <arg1> <arg2> ...
```
