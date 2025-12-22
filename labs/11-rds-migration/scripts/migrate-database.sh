#!/bin/bash

#############################################
# Database Migration Script
# Migrates local MySQL database to RDS
#############################################

set -e

echo "=========================================="
echo "Database Migration to Amazon RDS"
echo "=========================================="
echo ""

# Prompt for RDS endpoint
read -p "Enter RDS Endpoint Address: " RDS_ENDPOINT

# Database credentials
DB_USER="root"
DB_PASSWORD="Re:Start!9"
DB_NAME="cafe_db"
BACKUP_FILE="cafedb-backup.sql"

echo "[1/3] Creating backup of local database..."
mysqldump --user=$DB_USER --password="$DB_PASSWORD" \
  --databases $DB_NAME --add-drop-database > $BACKUP_FILE

if [ $? -eq 0 ]; then
    echo "✓ Backup created successfully: $BACKUP_FILE"
else
    echo "✗ Error creating backup"
    exit 1
fi

echo ""
echo "[2/3] Restoring backup to RDS instance..."
mysql --user=$DB_USER --password="$DB_PASSWORD" \
  --host=$RDS_ENDPOINT < $BACKUP_FILE

if [ $? -eq 0 ]; then
    echo "✓ Database restored successfully to RDS"
else
    echo "✗ Error restoring database"
    exit 1
fi

echo ""
echo "[3/3] Verifying migration..."
mysql --user=$DB_USER --password="$DB_PASSWORD" \
  --host=$RDS_ENDPOINT $DB_NAME \
  -e "SELECT COUNT(*) as table_count FROM information_schema.tables WHERE table_schema='$DB_NAME';"

echo ""
echo "=========================================="
echo "✓ Migration completed successfully!"
echo "=========================================="
echo "RDS Endpoint: $RDS_ENDPOINT"
echo "Database: $DB_NAME"
echo ""
