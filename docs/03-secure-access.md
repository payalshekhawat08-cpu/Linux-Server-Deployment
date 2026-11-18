# 03 - Secure Access (SSH keys)

Automated hardening: `scripts/03-harden-ssh.sh`.

## 1. Generate an SSH key on your HOST machine
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
Keys are saved in `~/.ssh/id_ed25519` (private) and `~/.ssh/id_ed25519.pub` (public).
**Never share or commit the private key.**

## 2. Copy the public key to the VM
Linux/macOS/Git Bash:
```bash
ssh-copy-id devops@<VM-IP>
# NAT users: ssh-copy-id -p 2222 devops@127.0.0.1
```
Windows PowerShell (no ssh-copy-id):
```powershell
type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh devops@<VM-IP> "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

## 3. Test key login
```bash
ssh devops@<VM-IP>
```
You must log in **without being asked for the account password** before moving on.

## 4. Fix permissions on the VM
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## 5. Harden the SSH server
Run `sudo ./scripts/03-harden-ssh.sh`, which installs `configs/sshd-hardening.conf` as
`/etc/ssh/sshd_config.d/99-hardening.conf`:

```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
MaxAuthTries 3
X11Forwarding no
```

Validate and reload:
```bash
sudo sshd -t
sudo systemctl reload ssh
```

Keep your current session open, and open a **second terminal** to confirm you can still log in.

## 6. Verify
```bash
ssh -o PubkeyAuthentication=no devops@<VM-IP>   # should be denied
ssh devops@<VM-IP>                              # should work
```

## 7. (Optional) Fail2ban
```bash
sudo apt install -y fail2ban
sudo systemctl enable --now fail2ban
sudo fail2ban-client status sshd
```

Next: [04 - Networking and firewall](04-networking-firewall.md)
