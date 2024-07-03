#!/bin/bash

# Define backup directory
backup_dir="/var/local/mesy-reports/backups"
current_date=$(date +"%Y%m%d")

# Backup docker-compose.yml and .env files
mkdir "$backup_dir/$current_date"
cp "/var/local/mesy-reports/setup/docker-compose.yml" "$backup_dir/$current_date/docker-compose.yml"
cp "/var/local/mesy-reports/setup/.env" "$backup_dir/$current_date/.env"
cp "/var/local/mesy-reports/setup/nginx.conf" "$backup_dir/$current_date/nginx.conf"

# Backup ldap service
tar -czvf "$backup_dir/$current_date/ldap_backup_$current_date.tar.gz" -C /var/local/mesy-reports/ldap .
tar -czvf "$backup_dir/$current_date/slapd.d_backup_$current_date.tar.gz" -C /var/local/mesy-reports/slapd.d .

# Backup db service
tar -czvf "$backup_dir/$current_date/db_backup_$current_date.tar.gz" -C /var/local/mesy-reports/db .

# Backup arc service
tar -czvf "$backup_dir/$current_date/arc_backup_$current_date.tar.gz" -C /var/local/mesy-reports/wildfly .

# Backup oviyam service
tar -czvf "$backup_dir/$current_date/oviyam_backup_$current_date.tar.gz" -C /var/local/mesy-reports/oviyam .

# Backup reportsdb service
tar -czvf "$backup_dir/$current_date/reportsdb_backup_$current_date.tar.gz" -C /var/local/mesy-reports/reportsdb .

echo "Backup completed. Backup files are in: $backup_dir"