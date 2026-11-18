#!/usr/bin/env bash
# Configure UFW: deny incoming by default, allow SSH and HTTP.
# Usage: sudo ./04-configure-firewall.sh
set -euo pipefail

if [[ $EUID -ne 0 ]]; then echo "Run as root: sudo $0"; exit 1; fi

ufw default deny incoming
ufw default allow outgoing

# Allow SSH first so we do not lock ourselves out.
ufw allow 22/tcp comment 'SSH'
ufw allow 80/tcp comment 'HTTP'

ufw --force enable
ufw status verbose
