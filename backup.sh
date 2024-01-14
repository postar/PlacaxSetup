#!/bin/bash

# Define backup directory
backup_dir="/var/local/placax-reports/backups"
current_date=$(date +"%Y%m%d")

# Backup docker-compose.yml and .env files
mkdir "$backup_dir/$current_date"
cp "/var/local/placax-reports/setup/docker-compose.yml" "$backup_dir/$current_date/docker-compose.yml"
cp "/var/local/placax-reports/setup/.env" "$backup_dir/$current_date/.env"
cp "/var/local/placax-reports/setup/nginx.conf" "$backup_dir/$current_date/nginx.conf"

# Backup ldap service
tar -czvf "$backup_dir/$current_date/ldap_backup_$current_date.tar.gz" -C /var/local/placax-reports/ldap .
tar -czvf "$backup_dir/$current_date/slapd.d_backup_$current_date.tar.gz" -C /var/local/placax-reports/slapd.d .

# Backup db service
tar -czvf "$backup_dir/$current_date/db_backup_$current_date.tar.gz" -C /var/local/placax-reports/db .

# Backup arc service
tar -czvf "$backup_dir/$current_date/arc_backup_$current_date.tar.gz" -C /var/local/placax-reports/wildfly .

# Backup oviyam service
tar -czvf "$backup_dir/$current_date/oviyam_backup_$current_date.tar.gz" -C /var/local/placax-reports/oviyam .

# Backup reportsdb service
tar -czvf "$backup_dir/$current_date/reportsdb_backup_$current_date.tar.gz" -C /var/local/placax-reports/reportsdb .

# Backup adminweb service
tar -czvf "$backup_dir/$current_date/adminweb_backup_$current_date.tar.gz" -C /var/local/placax-reports/setup/nginx.conf nginx.conf

echo "Backup completed. Backup files are in: $backup_dir"