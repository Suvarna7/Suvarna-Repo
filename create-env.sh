#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Since all 5 parameters are not present script terminated"
   exit 0
else 
 echo "Value of AMI ID=" $1
 echo "Value of key-name=" $2
 echo "Value of security-group=" $3
 echo "Value of launch-configuration=" $4
 echo "Value of count="$5
fi
 
echo "Creating load balancer"
aws elb create-load-balancer --load-balancer-name ITMO544sj --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-5e511128 --security-groups $3

echo "Creating launch configuration"

aws autoscaling create-launch-configuration --launch-configuration-name $4 --image-id $1 --security-group $3 --key-name $2 --instance-type t2.micro --user-data file://installenv.sh
echo "Creating auto scaling group to launch intances"
aws autoscaling create-auto-scaling-group --auto-scaling-group-name server-rg --launch-configuration $4 --availability-zone us-west-2b --load-balancer-name ITMO544sj --max-size 5 --min-size 2 --desired-capacity $5
