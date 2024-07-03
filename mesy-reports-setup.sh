#Install Docker
echo "Installing Docker"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo apt-get install rclone -y

echo "Installing Cloudflared"
# Add cloudflare gpg key
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# install cloudflared
sudo apt-get update && sudo apt-get install cloudflared -y

# install rclone
sudo curl https://rclone.org/install.sh | sudo bash

sysctl -w vm.swappiness=1
echo 'vm.swappiness=1' >> /etc/sysctl.conf
sysctl -w vm.max_map_count=262144
echo 'vm.max_map_count=262144' >> /etc/sysctl.conf
mkdir -p /var/local/mesy-reports/esdatadir
chmod g+rwx /var/local/mesy-reports/esdatadir
chgrp 0 /var/local/mesy-reports/esdatadir
mkdir -p /var/local/mesy-reports/logstash
touch /var/local/mesy-reports/logstash/filter-hashtree
chown 1000:1000 /var/local/mesy-reports/logstash/filter-hashtree
mkdir -p /var/local/mesy-reports/backups
wget -P /var/local/mesy-reports/backups https://raw.githubusercontent.com/postar/PlacaxSetup/main/backup.sh
wget -P /var/local/mesy-reports/backups https://raw.githubusercontent.com/postar/PlacaxSetup/main/restore.sh
chmod +x /var/local/mesy-reports/backups/restore.sh
chmod +x /var/local/mesy-reports/backups/backup.sh

mkdir /var/local/mesy-reports/setup
wget -P /var/local/mesy-reports/setup/ https://raw.githubusercontent.com/postar/PlacaxSetup/main/docker-compose.yml
wget -P /var/local/mesy-reports/setup/ https://raw.githubusercontent.com/postar/PlacaxSetup/main/.env
wget -P /var/local/mesy-reports/setup/ https://raw.githubusercontent.com/postar/PlacaxSetup/main/nginx.conf
wget -P /var/local/mesy-reports/setup/ https://raw.githubusercontent.com/postar/PlacaxSetup/main/oviyam2-7-config.xml

mkdir /var/local/mesy-reports/ohif
wget -P /var/local/mesy-reports/ohif/ https://raw.githubusercontent.com/postar/PlacaxSetup/main/ohif/app-config.js
wget -P /var/local/mesy-reports/ohif/ https://raw.githubusercontent.com/postar/PlacaxSetup/main/ohif/nginx.conf

cd /var/local/mesy-reports/setup

generate_password() {
    pw_length=12  # Longitud de la contraseña
    pw=$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9' | head -c "$pw_length")
    echo "$pw"
}

# Ruta al archivo de texto existente
pwFile=".env"

# Generar una contraseña aleatoria
newPW=$(generate_password)

# Eliminar la última línea del archivo
sed -i '$d' "$pwFile"

# Agregar la contraseña al archivo de texto
echo "DB_PW=$newPW" >> "$pwFile"

echo "Contraseña generada y agregada al archivo."