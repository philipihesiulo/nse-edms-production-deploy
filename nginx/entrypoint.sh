#!/bin/sh
set -e

# Install openssl explicitly as it is not included in the lightweight alpine image
apk add --no-cache openssl

# 1. Check if the certificate exists; if not, generate a dummy one to allow Nginx to start.
if [ ! -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ]; then
    echo "No SSL certificate found for $DOMAIN. Generating dummy certificate..."
    mkdir -p "/etc/letsencrypt/live/$DOMAIN"
    openssl req -x509 -nodes -newkey rsa:4096 -days 1 \
        -keyout "/etc/letsencrypt/live/$DOMAIN/privkey.pem" \
        -out "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" \
        -subj "/CN=localhost"
fi

# 2. Substitute environment variables in the Nginx config template
echo "Injecting configuration for $DOMAIN..."
envsubst '$DOMAIN $CERT_NAME $UPSTREAM $APP_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# 3. Execute the command passed to the docker container (usually "nginx -g daemon off;")
exec "$@"