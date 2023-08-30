
# Reemplaza con tu correo electrónico registrado en Cloudflare
CLOUDFLARE_EMAIL="tu_correo@example.com"

# Reemplaza con tu API key de Cloudflare
CLOUDFLARE_API_KEY="tu_api_key"

# Reemplaza con el subdominio que deseas usar para el túnel
SUBDOMAIN="serverX"

# Inicia el túnel de Cloudflare
cloudflared tunnel create $SUBDOMAIN

# Obtiene el identificador del túnel creado
TUNNEL_ID=$(cloudflared tunnel list | grep $SUBDOMAIN | awk '{print $1}')

# Inicia el túnel SSH usando el identificador del túnel
cloudflared tunnel run $TUNNEL_ID --ssh