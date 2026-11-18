# 07 - CLI Cheatsheet

## Navigation and files
```bash
pwd; ls -la; cd /path; mkdir dir; rm -r dir
cp a b; mv a b; cat file; less file; head file; tail -f file
find / -name "file" 2>/dev/null; grep -r "text" /etc/nginx
```

## Users and permissions
```bash
whoami; id; sudo adduser name; sudo usermod -aG group name
chmod 755 file; chown user:group file; sudo -l
```

## Processes
```bash
ps aux; top; htop; kill PID; kill -9 PID; pgrep -a name
```

## Services
```bash
systemctl status|start|stop|restart|enable|disable name
journalctl -u name -f
```

## Networking
```bash
ip a; ip route; ping host; curl -I url; ss -tulpn
nslookup host; dig host; resolvectl status
```

## Firewall
```bash
sudo ufw status verbose; sudo ufw allow 80/tcp; sudo ufw delete allow 80/tcp
```

## SSH
```bash
ssh-keygen -t ed25519; ssh-copy-id user@ip; ssh user@ip; scp file user@ip:/path
```

## Packages
```bash
sudo apt update; sudo apt upgrade -y; sudo apt install pkg; sudo apt remove pkg
```
