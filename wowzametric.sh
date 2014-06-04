#!/bin/bash

#Script to send the number of connections of a Wowza instance to the clowdwatch metrics.
#Author: Ciro Anunciacao
#Copyright: Copyright 2014 Ciro Anunciacao
#License: MIT
#Version: 1.0.0

#Set environment variables for the AWS Command Line Interface (http://aws.amazon.com/cli/)

#Set the path of your AWS credentials file (http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#config-file-location)
export AWS_CREDENTIAL_FILE=/opt/aws/aws_credential_file
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#Get ec2 instance-id and region. Works only on EC2 instances (of course).
instanceid=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
availabilityzone=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
region="`echo \"$availabilityzone\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"

#Set wowza parameters
wowzahost=127.0.0.1
wowzauser=[replace with your wowza user]
wowzapwd=[replace with your wowza password]

#Get wowza connections
wowzaconnections=`python wowzaconnections.py $wowzahost $wowzauser $wowzapwd`

#Publish the metric to cloudwatch using the name ConnectionCount for this specific instance.
aws cloudwatch put-metric-data --namespace "Wowza" --metric-name ConnectionCount --value $wowzaconnections --unit Count --region $region --dimensions "InstanceId=$instanceid"

#Publish the metric to cloudwatch using the name ConnectionCount using a dimension called WowzaType with the type "Edge".
#You can change it or use another dimensions if you want to.
aws cloudwatch put-metric-data --namespace "Wowza" --metric-name ConnectionCount --value $wowzaconnections --unit Count --region $region --dimensions "WowzaType=Edge"