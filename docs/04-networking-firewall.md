# 04 - Networking and Firewall

Automated version: `scripts/04-configure-firewall.sh`.

## 1. IP addressing
```bash
ip a                  # interfaces and IPs
ip route              # default gateway
hostname -I
```
- **Private IP**: address inside your network (e.g. `192.168.1.50`).
- **Loopback**: `127.0.0.1`, the machine itself.
- **Gateway**: the router the VM uses to reach other networks.
- **Netmask**: `/24` means the first 24 bits are the network.

## 2. DNS
```bash
resolvectl status          # DNS servers in use
nslookup google.com
dig google.com +short
cat /etc/hosts             # local name overrides
```
To map a name locally on your host, add to the host's hosts file:
```
<VM-IP>  myserver.local
```
Then browse `http://myserver.local`.

## 3. Ports
| Port | Service | Used for |
|------|---------|----------|
| 22   | SSH     | remote login |
| 80   | HTTP    | web traffic |
| 443  | HTTPS   | encrypted web traffic |

```bash
sudo ss -tulpn          # listening ports and owning processes
```

## 4. Firewall with UFW
Default policy: deny all incoming, allow all outgoing.
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH        # port 22 - do this BEFORE enabling!
sudo ufw allow 80/tcp
sudo ufw enable
sudo ufw status verbose
```
Remove a rule:
```bash
sudo ufw status numbered
sudo ufw delete <number>
```

## 5. Security-group concept
VirtualBox has no cloud "security groups", but UFW plays the same role. The rules map directly:

| Cloud security group rule | UFW equivalent |
|---------------------------|----------------|
| Inbound TCP 22 from anywhere | `ufw allow 22/tcp` |
| Inbound TCP 80 from anywhere | `ufw allow 80/tcp` |
| Inbound TCP 22 from one IP only | `ufw allow from 192.168.1.10 to any port 22 proto tcp` |
| Default deny inbound | `ufw default deny incoming` |

Restricting SSH to your host IP only is a good extra step:
```bash
sudo ufw delete allow OpenSSH
sudo ufw allow from <HOST-IP> to any port 22 proto tcp
```

Next: [05 - Deploy service](05-deploy-service.md)
