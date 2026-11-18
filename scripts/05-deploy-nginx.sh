#!/usr/bin/env bash
# Install Nginx and deploy the static site from ../web.
# Usage: sudo ./05-deploy-nginx.sh
set -euo pipefail

if [[ $EUID -ne 0 ]]; then echo "Run as root: sudo $0"; exit 1; fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_ROOT="/var/www/myserver"

echo "[1/5] Installing Nginx..."
apt-get update -y
apt-get install -y nginx

echo "[2/5] Deploying website to ${WEB_ROOT}..."
mkdir -p "$WEB_ROOT"
cp "$SCRIPT_DIR/../web/index.html" "$WEB_ROOT/index.html"
chown -R www-data:www-data "$WEB_ROOT"
chmod -R 755 "$WEB_ROOT"

echo "[3/5] Installing Nginx site config..."
cp "$SCRIPT_DIR/../configs/nginx-site.conf" /etc/nginx/sites-available/myserver
ln -sf /etc/nginx/sites-available/myserver /etc/nginx/sites-enabled/myserver
rm -f /etc/nginx/sites-enabled/default

echo "[4/5] Testing Nginx configuration..."
nginx -t

echo "[5/5] Enabling and restarting Nginx..."
systemctl enable nginx
systemctl restart nginx

echo "Deployed. Open http://$(hostname -I | awk '{print $1}') from your host."
