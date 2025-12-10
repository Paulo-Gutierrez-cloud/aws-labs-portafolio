#!/bin/bash
# AWS CLI Installation Script for Red Hat Linux
# This script automates the installation of AWS CLI v2

set -e  # Exit on error

echo "========================================="
echo "AWS CLI Installation Script"
echo "========================================="
echo ""

# Step 1: Download AWS CLI installer
echo "[1/4] Downloading AWS CLI installer..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
echo "✓ Download complete"
echo ""

# Step 2: Unzip the installer
echo "[2/4] Unzipping installer..."
unzip -u awscliv2.zip
echo "✓ Unzip complete"
echo ""

# Step 3: Install AWS CLI
echo "[3/4] Installing AWS CLI..."
sudo ./aws/install
echo "✓ Installation complete"
echo ""

# Step 4: Verify installation
echo "[4/4] Verifying installation..."
aws --version
echo ""

echo "========================================="
echo "✅ AWS CLI installed successfully!"
echo "========================================="
echo ""
echo "Next steps:"
echo "1. Run 'aws configure' to set up your credentials"
echo "2. Enter your AWS Access Key ID"
echo "3. Enter your AWS Secret Access Key"
echo "4. Enter your default region (e.g., us-west-2)"
echo "5. Enter your default output format (e.g., json)"
echo ""
echo "To test: aws iam list-users"
echo ""
