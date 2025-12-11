#!/bin/bash

#############################################
# EC2 Web Server Launch Script
# Automated EC2 instance deployment
#############################################

set -e

echo "=========================================="
echo "EC2 Web Server Launch Script"
echo "=========================================="
echo ""

# Set the Region
AZ=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFAULT_REGION=${AZ::-1}

echo "[1/5] Retrieving latest Amazon Linux 2 AMI..."
AMI=$(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameters[0].[Value]' --output text)
echo "AMI ID: $AMI"

echo "[2/5] Retrieving Public Subnet ID..."
SUBNET=$(aws ec2 describe-subnets --filters 'Name=tag:Name,Values=Public Subnet' --query Subnets[].SubnetId --output text)
echo "Subnet ID: $SUBNET"

echo "[3/5] Retrieving Web Security Group ID..."
SG=$(aws ec2 describe-security-groups --filters Name=group-name,Values=WebSecurityGroup --query SecurityGroups[].GroupId --output text)
echo "Security Group ID: $SG"

echo "[4/5] Downloading UserData script..."
wget -q https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-RSJAWS-1-23732/171-lab-JAWS-create-ec2/s3/UserData.txt

echo "[5/5] Launching EC2 instance..."
INSTANCE=$(aws ec2 run-instances \
  --image-id $AMI \
  --subnet-id $SUBNET \
  --security-group-ids $SG \
  --user-data file:///home/ec2-user/UserData.txt \
  --instance-type t3.micro \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Web Server}]' \
  --query 'Instances[*].InstanceId' \
  --output text)

echo ""
echo "=========================================="
echo "✓ Instance launched successfully!"
echo "=========================================="
echo "Instance ID: $INSTANCE"
echo ""
echo "Waiting for instance to be running..."

# Wait for instance to be running
aws ec2 wait instance-running --instance-ids $INSTANCE

echo "✓ Instance is now running!"

# Get public DNS name
DNS=$(aws ec2 describe-instances --instance-ids $INSTANCE --query Reservations[].Instances[].PublicDnsName --output text)
echo ""
echo "Web Server URL: http://$DNS"
echo ""
