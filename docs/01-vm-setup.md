# 01 - Create the VM in VirtualBox

## Requirements
- Oracle VirtualBox installed on the host
- Ubuntu Server 22.04 LTS ISO (from ubuntu.com/download/server)
- At least 2 GB free RAM and 20 GB free disk

## 1. Create the virtual machine
1. Open VirtualBox → **New**.
2. Name: `ubuntu-server`, Type: **Linux**, Version: **Ubuntu (64-bit)**.
3. Select the downloaded ISO (or attach it later under Storage).
4. Check **Skip Unattended Installation** so you control the install.
5. Hardware: **2048 MB RAM**, **2 CPUs**.
6. Hard disk: **20 GB**, dynamically allocated.

## 2. Network adapter
Open **Settings → Network → Adapter 1**.

**Option A - Bridged Adapter (recommended)**
- Attached to: *Bridged Adapter*, pick your active Wi-Fi/Ethernet card.
- The VM gets an IP on your home/LAN network and is reachable directly from the host.

**Option B - NAT with port forwarding**
- Attached to: *NAT* → Advanced → **Port Forwarding**.

| Name | Protocol | Host IP   | Host Port | Guest Port |
|------|----------|-----------|-----------|------------|
| ssh  | TCP      | 127.0.0.1 | 2222      | 22         |
| http | TCP      | 127.0.0.1 | 8080      | 80         |

Then connect with `ssh -p 2222 user@127.0.0.1` and browse `http://127.0.0.1:8080`.

## 3. Install Ubuntu Server
Start the VM and follow the installer:
1. Language and keyboard layout.
2. Install type: **Ubuntu Server** (not minimized).
3. Network: accept DHCP.
4. Storage: use the entire disk (default).
5. Profile: set your name, server name (`ubuntu-server`), username and password.
6. **Enable "Install OpenSSH server"**.
7. Skip extra snaps.
8. Reboot and remove the ISO when asked.

## 4. First login and find the IP
```bash
ip a
hostname -I
```
Note the IP address (for example `192.168.1.50`); it is used throughout this project.

## 5. (Optional) Take a snapshot
VirtualBox → **Machine → Take Snapshot** → name it `fresh-install`. You can roll back
if something breaks later.

Next: [02 - Linux configuration](02-linux-configuration.md)
