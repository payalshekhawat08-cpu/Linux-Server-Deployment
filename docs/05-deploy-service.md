# 05 - Deploy the Service (Nginx)

Automated version: `scripts/05-deploy-nginx.sh`.

## 1. Install Nginx
```bash
sudo apt update
sudo apt install -y nginx
sudo systemctl enable --now nginx
systemctl status nginx
```

## 2. Deploy the website
```bash
sudo mkdir -p /var/www/myserver
sudo cp web/index.html /var/www/myserver/index.html
sudo chown -R www-data:www-data /var/www/myserver
sudo chmod -R 755 /var/www/myserver
```

## 3. Configure the Nginx site
```bash
sudo cp configs/nginx-site.conf /etc/nginx/sites-available/myserver
sudo ln -s /etc/nginx/sites-available/myserver /etc/nginx/sites-enabled/myserver
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

## 4. Check logs
```bash
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

## 5. Make sure the firewall allows HTTP
```bash
sudo ufw allow 80/tcp
```

Next: [06 - Testing](06-testing.md)
