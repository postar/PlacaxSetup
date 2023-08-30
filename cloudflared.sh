apt update
apt upgrade -y

cloudflared login

# Reemplaza con el subdominio que deseas usar para el túnel
SUBDOMAIN="serverx"

# Inicia el túnel de Cloudflare
cloudflared tunnel create $SUBDOMAIN

# Obtiene el identificador del túnel creado
TUNNEL_ID=$(cloudflared tunnel list | grep $SUBDOMAIN | awk '{print $1}')

echo "$TUNNEL_ID" > tunnel.id

# Inicia el túnel SSH usando el identificador del túnel
cloudflared tunnel run $TUNNEL_ID --ssh