#!/usr/bin/env bash
# Update the system and install base tools.
# Usage: sudo ./01-configure-system.sh [hostname] [timezone]
set -euo pipefail

if [[ $EUID -ne 0 ]]; then echo "Run as root: sudo $0"; exit 1; fi

HOSTNAME_NEW="${1:-ubuntu-server}"
TIMEZONE="${2:-UTC}"

echo "[1/4] Updating packages..."
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

echo "[2/4] Installing base tools..."
apt-get install -y curl vim net-tools htop ufw dnsutils

echo "[3/4] Setting hostname to ${HOSTNAME_NEW}..."
hostnamectl set-hostname "${HOSTNAME_NEW}"

echo "[4/4] Setting timezone to ${TIMEZONE}..."
timedatectl set-timezone "${TIMEZONE}"

echo "System configuration complete."
