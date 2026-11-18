# 06 - Test Connectivity

Automated version: `scripts/06-test-connectivity.sh` (run on the VM).

## From the HOST machine

| Test | Command | Expected |
|------|---------|----------|
| Reachability | `ping <VM-IP>` | replies received |
| SSH port open | `nc -zv <VM-IP> 22` | succeeded |
| HTTP port open | `nc -zv <VM-IP> 80` | succeeded |
| Web response | `curl -I http://<VM-IP>` | `HTTP/1.1 200 OK` |
| Web content | `curl http://<VM-IP>` | HTML of the page |
| Browser | open `http://<VM-IP>` | deployed page shown |
| SSH login | `ssh devops@<VM-IP>` | logs in with key |
| Blocked port | `nc -zv <VM-IP> 3306` | connection refused or timeout |

NAT users: replace `<VM-IP>` with `127.0.0.1` and use ports `2222` (SSH) and `8080` (HTTP).

## From the VM
```bash
sudo ss -tulpn | grep -E ':22|:80'
sudo ufw status verbose
systemctl is-active nginx ssh
curl -I http://localhost
```
