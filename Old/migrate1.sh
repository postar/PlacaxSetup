sudo mv /var/local/placax-reports/wildfly /tmp
docker exec ldap export-data > /tmp/backup/data.ldif
docker exec ldap export-users > /tmp/backup/users.ldif
docker exec ldap export-realm-management > /tmp/backup/realm-management.ldif
docker exec ldap export-account > /tmp/backup/account.ldif
docker exec ldap export-realm-managment > /tmp/backup/realm-management.ldif
docker stop ldap

docker exec db dump > db_backup.sql