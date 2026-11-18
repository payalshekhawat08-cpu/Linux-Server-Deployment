# Linux Server Deployment on VirtualBox (Ubuntu Server)

A hands-on project that walks through deploying a secured Linux web server from scratch:
**Create VM → Configure Linux → Secure Access → Deploy Service → Test Connectivity.**

The server runs **Ubuntu Server (CLI only)** inside **Oracle VirtualBox** on a local machine
and serves a static website using **Nginx**.

---

## Key Objectives

1. **Linux CLI fundamentals** – files, permissions, users, groups, process management, services, SSH keys.
2. **Networking basics** – IP addressing, DNS, ports, firewalls, security-group-style rules.
3. **Deploy a Linux server** – Create VM → Configure Linux → Secure Access → Deploy Service → Test Connectivity.

## Architecture

```
┌──────────────────────┐        SSH (22) / HTTP (80)        ┌─────────────────────────────┐
│  Host machine        │ ─────────────────────────────────► │  VirtualBox VM              │
│  (Windows/Mac/Linux) │                                    │  Ubuntu Server 22.04 LTS    │
│  browser, ssh, curl  │ ◄───────────────────────────────── │  UFW firewall + Nginx       │
└──────────────────────┘          Bridged / NAT             └─────────────────────────────┘
```

## Tech Stack

| Component        | Choice                      |
|------------------|-----------------------------|
| Hypervisor       | Oracle VirtualBox           |
| OS               | Ubuntu Server 22.04 LTS     |
| Access           | OpenSSH (key-based auth)    |
| Firewall         | UFW (Uncomplicated Firewall)|
| Web service      | Nginx                       |

## Repository Structure

```
linux-server-deployment/
├── README.md
├── LICENSE
├── .gitignore
├── docs/
│   ├── 01-vm-setup.md              # Create the VM in VirtualBox, install Ubuntu
│   ├── 02-linux-configuration.md   # Updates, users, groups, permissions, processes, services
│   ├── 03-secure-access.md         # SSH keys, disable password login, fail2ban
│   ├── 04-networking-firewall.md   # IP, DNS, ports, UFW, security-group mapping
│   ├── 05-deploy-service.md        # Install and configure Nginx, deploy site
│   ├── 06-testing.md               # Test connectivity (ping, curl, ss, browser)
│   ├── 07-cli-cheatsheet.md        # Commands used in this project
│   └── troubleshooting.md
├── scripts/
│   ├── 01-configure-system.sh
│   ├── 02-create-user.sh
│   ├── 03-harden-ssh.sh
│   ├── 04-configure-firewall.sh
│   ├── 05-deploy-nginx.sh
│   └── 06-test-connectivity.sh
├── configs/
│   ├── nginx-site.conf
│   └── sshd-hardening.conf
└── web/
    └── index.html
```

## Quick Start

On the **Ubuntu VM** (after installing the OS, see `docs/01-vm-setup.md`):

```bash
# Get this repository onto the VM (git clone using the URL from the green "Code" button on GitHub), then:
cd linux-server-deployment
chmod +x scripts/*.sh

sudo ./scripts/01-configure-system.sh
sudo ./scripts/02-create-user.sh devops
# From your HOST machine: copy your SSH key to the VM (see docs/03-secure-access.md)
sudo ./scripts/03-harden-ssh.sh          # only AFTER key login works!
sudo ./scripts/04-configure-firewall.sh
sudo ./scripts/05-deploy-nginx.sh
./scripts/06-test-connectivity.sh
```

> **Warning:** run `03-harden-ssh.sh` only after you have confirmed that SSH key login works,
> otherwise you can lock yourself out of the VM.

## Walkthrough Summary

| Step | What you do | Doc |
|------|-------------|-----|
| 1 | Create VM in VirtualBox and install Ubuntu Server | [01-vm-setup](docs/01-vm-setup.md) |
| 2 | Update system, create users/groups, set permissions, manage services | [02-linux-configuration](docs/02-linux-configuration.md) |
| 3 | Set up SSH keys, disable password and root login | [03-secure-access](docs/03-secure-access.md) |
| 4 | Understand IPs, DNS, ports; configure UFW firewall | [04-networking-firewall](docs/04-networking-firewall.md) |
| 5 | Install Nginx and deploy the website | [05-deploy-service](docs/05-deploy-service.md) |
| 6 | Verify everything works end to end | [06-testing](docs/06-testing.md) |

## Expected Result

- SSH works **only with keys**, as a non-root user.
- Firewall allows only ports **22 (SSH)** and **80 (HTTP)**.
- Opening `http://the VM's IP` from the host browser shows the deployed page.

## What I Learned

- Managing a server entirely from the command line.
- Users, groups, and file permissions (`chmod`, `chown`, `sudo`).
- Starting, stopping and inspecting services with `systemctl` and logs with `journalctl`.
- Key-based SSH and why password login is risky.
- How ports and firewalls control exposure, and how this maps to cloud security groups.

## License

MIT, see [LICENSE](LICENSE).
