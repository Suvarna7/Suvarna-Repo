#!/bin/bash
echo "Creating load balancer"
aws elb create-load-balancer --load-balancer-name ITMO544sj --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-5e511128 --security-groups sg-a6b560df
echo "Creating launch configuration"
aws autoscaling create-launch-configuration --launch-configuration-name itmo544sjconfigure --image-id ami-06b94666 --security-group sg-a6b560df --key-name insomnia --instance-type t2.micro --user-data file://installenv.sh
echo "Creating auto scaling group to launch intances"
aws autoscaling create-auto-scaling-group --auto-scaling-group-name server-rg --launch-configuration itmo544sjconfigure --availability-zone us-west-2b --load-balancer-name ITMO544sj --max-size 5 --min-size 2 --desired-capacity 3

