#!/bin/bash

#############################################
# Create AMI using AWS CLI
# Optional Challenge Script
#############################################

echo "=========================================="
echo "Create AMI using AWS CLI"
echo "=========================================="
echo ""

# Get instance ID (replace with your instance ID)
read -p "Enter Instance ID: " INSTANCE_ID

# Get AMI name
read -p "Enter AMI Name: " AMI_NAME

# Create AMI
echo "Creating AMI from instance $INSTANCE_ID..."
AMI_ID=$(aws ec2 create-image \
  --instance-id $INSTANCE_ID \
  --name "$AMI_NAME" \
  --description "AMI created using AWS CLI" \
  --query 'ImageId' \
  --output text)

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ AMI created successfully!"
    echo "AMI ID: $AMI_ID"
    echo ""
    echo "Waiting for AMI to become available..."
    aws ec2 wait image-available --image-ids $AMI_ID
    echo "✓ AMI is now available!"
else
    echo "✗ Error creating AMI"
    exit 1
fi
