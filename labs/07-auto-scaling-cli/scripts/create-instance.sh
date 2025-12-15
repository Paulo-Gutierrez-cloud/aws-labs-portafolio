#!/bin/bash

#############################################
# Create EC2 Instance with AWS CLI
# Auto Scaling Lab
#############################################

echo "=========================================="
echo "Create EC2 Instance for Auto Scaling"
echo "=========================================="
echo ""

# Prompt for required values
read -p "Enter Key Name: " KEYNAME
read -p "Enter AMI ID: " AMIID
read -p "Enter Security Group ID (HTTPACCESS): " HTTPACCESS
read -p "Enter Subnet ID: " SUBNETID

echo ""
echo "Creating EC2 instance..."

# Create instance
INSTANCE_ID=$(aws ec2 run-instances \
  --key-name $KEYNAME \
  --instance-type t3.micro \
  --image-id $AMIID \
  --user-data file:///home/ec2-user/UserData.txt \
  --security-group-ids $HTTPACCESS \
  --subnet-id $SUBNETID \
  --associate-public-ip-address \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=WebServer}]' \
  --output text \
  --query 'Instances[*].InstanceId')

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Instance created successfully!"
    echo "Instance ID: $INSTANCE_ID"
    echo ""
    echo "Waiting for instance to be running..."
    
    # Wait for instance to be running
    aws ec2 wait instance-running --instance-ids $INSTANCE_ID
    
    echo "✓ Instance is now running!"
    echo ""
    
    # Get public DNS name
    PUBLIC_DNS=$(aws ec2 describe-instances \
      --instance-id $INSTANCE_ID \
      --query 'Reservations[0].Instances[0].NetworkInterfaces[0].Association.PublicDnsName' \
      --output text)
    
    echo "Public DNS: $PUBLIC_DNS"
    echo "Web Server URL: http://$PUBLIC_DNS/index.php"
    echo ""
    echo "Wait 5 minutes for web server installation to complete."
else
    echo "✗ Error creating instance"
    exit 1
fi
