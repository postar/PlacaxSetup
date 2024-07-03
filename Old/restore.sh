#!/bin/bash

# Define backup directory
backup_dir="/var/local/placax-reports/backups"

# Prompt the user for the date and time of the backup to restore
read -p "Enter the date and time of the backup (format: YYYYMMDD): " restore_date

# Function to create directories if they don't exist
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# Restore docker-compose.yml and .env files
create_directory /var/local/placax-reports/setup
cp "$backup_dir/$restore_date/docker-compose.yml" /var/local/placax-reports/setup/docker-compose.yml
cp "$backup_dir/$restore_date/.env" /var/local/placax-reports/setup/.env
cp "$backup_dir/$restore_date/nginx.conf" /var/local/placax-reports/setup/nginx.conf

# Restore ldap service
create_directory /var/local/placax-reports/ldap
create_directory /var/local/placax-reports/slapd.d
tar -xzvf "$backup_dir/$restore_date/ldap_backup_$restore_date.tar.gz" -C /var/local/placax-reports/ldap
tar -xzvf "$backup_dir/$restore_date/slapd.d_backup_$restore_date.tar.gz" -C /var/local/placax-reports/slapd.d

# Restore db service
create_directory /var/local/placax-reports/db
tar -xzvf "$backup_dir/$restore_date/db_backup_$restore_date.tar.gz" -C /var/local/placax-reports/db

# Restore arc service
create_directory /var/local/placax-reports/wildfly
tar -xzvf "$backup_dir/$restore_date/arc_backup_$restore_date.tar.gz" -C /var/local/placax-reports/wildfly

# Restore oviyam service
create_directory /var/local/placax-reports/oviyam
tar -xzvf "$backup_dir/$restore_date/oviyam_backup_$restore_date.tar.gz" -C /var/local/placax-reports/oviyam

# Restore reportsdb service
create_directory /var/local/placax-reports/reportsdb
tar -xzvf "$backup_dir/$restore_date/reportsdb_backup_$restore_date.tar.gz" -C /var/local/placax-reports/reportsdb


echo "Restoration completed."