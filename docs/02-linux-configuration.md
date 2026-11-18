# 02 - Configure Linux

Automated version: `scripts/01-configure-system.sh` and `scripts/02-create-user.sh`.

## 1. Update the system
```bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y curl vim net-tools htop ufw
```

## 2. Hostname and timezone
```bash
sudo hostnamectl set-hostname ubuntu-server
sudo timedatectl set-timezone Asia/Kolkata   # change to your timezone
timedatectl
```

## 3. Users and groups
```bash
sudo adduser devops                  # create a user
sudo usermod -aG sudo devops         # give admin rights
sudo groupadd webadmins              # create a group
sudo usermod -aG webadmins devops    # add user to group
id devops                            # verify
getent group webadmins
```

## 4. Files and permissions
```bash
mkdir -p ~/lab && cd ~/lab
touch notes.txt
ls -l notes.txt

chmod 644 notes.txt        # owner rw, group r, others r
chmod 600 notes.txt        # owner rw only
chmod +x script.sh         # make executable
sudo chown devops:webadmins notes.txt
```

Permission reference:

| Number | Meaning       |
|--------|---------------|
| 7      | read+write+execute |
| 6      | read+write    |
| 5      | read+execute  |
| 4      | read only     |

Example: `755` = owner rwx, group r-x, others r-x.

## 5. Process management
```bash
ps aux | head
top                          # press q to quit
htop
pgrep -a nginx
sleep 300 &                  # run a background process
jobs
kill <PID>                   # graceful stop
kill -9 <PID>                # force stop
```

## 6. Services with systemd
```bash
systemctl status ssh
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl enable nginx      # start at boot
systemctl is-enabled nginx
journalctl -u nginx --since "10 min ago"
```

Next: [03 - Secure access](03-secure-access.md)
