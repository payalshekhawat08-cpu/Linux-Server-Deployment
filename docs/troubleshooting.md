# Troubleshooting

| Problem | Likely cause | Fix |
|---------|--------------|-----|
| Cannot ping VM | Wrong adapter mode or Wi-Fi blocks bridging | Try Bridged on another adapter or use NAT + port forwarding |
| `ssh: connect refused` | SSH not running or blocked | `sudo systemctl start ssh`; `sudo ufw allow OpenSSH` |
| `Permission denied (publickey)` | Key not installed or wrong permissions | Re-run `ssh-copy-id`; `chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys` |
| Locked out after hardening | Password login disabled before key worked | Log in via VirtualBox console, remove `/etc/ssh/sshd_config.d/99-hardening.conf`, `sudo systemctl reload ssh` |
| Website not loading | Nginx down or firewall blocks 80 | `systemctl status nginx`; `sudo ufw allow 80/tcp`; `sudo nginx -t` |
| Nginx shows default page | Default site still enabled | `sudo rm /etc/nginx/sites-enabled/default`; reload |
| 403 Forbidden | Wrong permissions on web root | `sudo chown -R www-data:www-data /var/www/myserver; sudo chmod -R 755 /var/www/myserver` |
| VM IP changed | DHCP lease changed | Run `hostname -I` again, or set a static IP / DHCP reservation |
| `nginx -t` fails | Syntax error in config | Read the error line number and fix `configs/nginx-site.conf` |
