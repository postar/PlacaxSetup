#!/bin/bash

# Define backup directory
backup_dir="/var/local/mesy-reports/backups"

# Prompt the user for the date and time of the backup to restore
read -p "Enter the date and time of the backup (format: YYYYMMDD): " restore_date

# Function to create directories if they don't exist
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# Restore docker-compose.yml and .env files
create_directory /var/local/mesy-reports/setup
cp "$backup_dir/$restore_date/docker-compose.yml" /var/local/mesy-reports/setup/docker-compose.yml
cp "$backup_dir/$restore_date/.env" /var/local/mesy-reports/setup/.env
cp "$backup_dir/$restore_date/nginx.conf" /var/local/mesy-reports/setup/nginx.conf

# Restore ldap service
create_directory /var/local/mesy-reports/ldap
create_directory /var/local/mesy-reports/slapd.d
tar -xzvf "$backup_dir/$restore_date/ldap_backup_$restore_date.tar.gz" -C /var/local/mesy-reports/ldap
tar -xzvf "$backup_dir/$restore_date/slapd.d_backup_$restore_date.tar.gz" -C /var/local/mesy-reports/slapd.d

# Restore db service
create_directory /var/local/mesy-reports/db
tar -xzvf "$backup_dir/$restore_date/db_backup_$restore_date.tar.gz" -C /var/local/mesy-reports/db

# Restore arc service
create_directory /var/local/mesy-reports/wildfly
tar -xzvf "$backup_dir/$restore_date/arc_backup_$restore_date.tar.gz" -C /var/local/mesy-reports/wildfly

# Restore oviyam service
create_directory /var/local/mesy-reports/oviyam
tar -xzvf "$backup_dir/$restore_date/oviyam_backup_$restore_date.tar.gz" -C /var/local/mesy-reports/oviyam

# Restore reportsdb service
create_directory /var/local/mesy-reports/reportsdb
tar -xzvf "$backup_dir/$restore_date/reportsdb_backup_$restore_date.tar.gz" -C /var/local/mesy-reports/reportsdb


echo "Restoration completed."