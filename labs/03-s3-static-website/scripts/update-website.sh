#!/bin/bash

#############################################
# Website Update Script for S3
# S3 Static Website Lab
#############################################

# Configuration
BUCKET_NAME="my-bucket"  # Replace with your bucket name
SOURCE_DIR="/home/ec2-user/sysops-activity-files/static-website/"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=========================================="
echo "S3 Website Update Script"
echo -e "==========================================${NC}"
echo ""

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist"
    exit 1
fi

# Sync files to S3
echo -e "${BLUE}Synchronizing files to S3...${NC}"
aws s3 sync $SOURCE_DIR s3://$BUCKET_NAME/ --acl public-read

# Check if sync was successful
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ Website updated successfully!${NC}"
    
    # Display website URL
    REGION=$(aws configure get region)
    echo -e "${GREEN}Website URL: http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com${NC}"
else
    echo ""
    echo "✗ Error updating website"
    exit 1
fi
