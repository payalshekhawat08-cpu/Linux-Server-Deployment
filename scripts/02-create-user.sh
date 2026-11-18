#!/usr/bin/env bash
# Create an admin user and a webadmins group.
# Usage: sudo ./02-create-user.sh <username>
set -euo pipefail

if [[ $EUID -ne 0 ]]; then echo "Run as root: sudo $0 <username>"; exit 1; fi
USERNAME="${1:-}"
if [[ -z "$USERNAME" ]]; then echo "Usage: sudo $0 <username>"; exit 1; fi

if id "$USERNAME" &>/dev/null; then
  echo "User $USERNAME already exists."
else
  adduser --gecos "" "$USERNAME"
fi

usermod -aG sudo "$USERNAME"
getent group webadmins >/dev/null || groupadd webadmins
usermod -aG webadmins "$USERNAME"

install -d -m 700 -o "$USERNAME" -g "$USERNAME" "/home/$USERNAME/.ssh"
touch "/home/$USERNAME/.ssh/authorized_keys"
chown "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh/authorized_keys"
chmod 600 "/home/$USERNAME/.ssh/authorized_keys"

echo "User $USERNAME is ready."
id "$USERNAME"
echo "Next: from your host run: ssh-copy-id $USERNAME@<VM-IP>"
