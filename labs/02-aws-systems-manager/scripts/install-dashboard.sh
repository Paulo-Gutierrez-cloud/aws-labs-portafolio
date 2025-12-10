#!/bin/bash

#############################################
# Widget Manufacturing Dashboard Installer
# AWS Systems Manager Lab
#############################################

set -e  # Exit on error

echo "=========================================="
echo "Widget Manufacturing Dashboard Installer"
echo "=========================================="
echo ""

# Update the system
echo "[1/6] Updating system packages..."
sudo yum update -y

# Install Apache HTTP Server
echo "[2/6] Installing Apache HTTP Server..."
sudo yum install -y httpd

# Install PHP and required modules
echo "[3/6] Installing PHP and modules..."
sudo yum install -y php php-mysql php-gd php-xml php-mbstring

# Download and install AWS SDK for PHP
echo "[4/6] Installing AWS SDK for PHP..."
cd /var/www/html
sudo wget -q https://github.com/aws/aws-sdk-php/releases/download/3.x/aws.phar

# Download and install the Widget Manufacturing Dashboard application
echo "[5/6] Installing Widget Manufacturing Dashboard..."
sudo wget -q https://aws-tc-largeobjects.s3.amazonaws.com/CUR-TF-100-RESTRT-1/dashboard-app.zip
sudo unzip -q dashboard-app.zip
sudo rm dashboard-app.zip

# Set proper permissions
echo "[6/6] Configuring permissions and starting services..."
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Verify installation
if systemctl is-active --quiet httpd; then
    echo ""
    echo "=========================================="
    echo "✅ Installation completed successfully!"
    echo "=========================================="
    echo ""
    echo "Dashboard is now accessible at:"
    echo "http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
    echo ""
else
    echo ""
    echo "❌ Error: Apache failed to start"
    exit 1
fi
