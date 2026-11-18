#!/usr/bin/env bash
# Harden the SSH server: key-only auth, no root login.
# WARNING: confirm key-based login works BEFORE running this.
# Usage: sudo ./03-harden-ssh.sh
set -euo pipefail

if [[ $EUID -ne 0 ]]; then echo "Run as root: sudo $0"; exit 1; fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/../configs/sshd-hardening.conf"
DEST="/etc/ssh/sshd_config.d/99-hardening.conf"

read -r -p "Have you verified SSH key login works from your host? (yes/no): " ANSWER
if [[ "$ANSWER" != "yes" ]]; then
  echo "Aborting. Set up and test key login first (docs/03-secure-access.md)."
  exit 1
fi

install -m 644 "$SRC" "$DEST"

echo "Validating SSH configuration..."
sshd -t

systemctl reload ssh
echo "SSH hardened. Keep this session open and test a new login in a second terminal."
