#!/usr/bin/env bash
# Run local checks on the VM to verify the deployment.
# Usage: ./06-test-connectivity.sh
set -uo pipefail

PASS=0; FAIL=0
check() {
  local name="$1"; shift
  if "$@" &>/dev/null; then
    echo "[PASS] $name"; PASS=$((PASS+1))
  else
    echo "[FAIL] $name"; FAIL=$((FAIL+1))
  fi
}

check "SSH service is active"      systemctl is-active --quiet ssh
check "Nginx service is active"    systemctl is-active --quiet nginx
check "Nginx enabled at boot"      systemctl is-enabled --quiet nginx
check "Port 22 is listening"       bash -c "ss -tln | grep -q ':22 '"
check "Port 80 is listening"       bash -c "ss -tln | grep -q ':80 '"
check "UFW is active"              bash -c "sudo ufw status | grep -q 'Status: active'"
check "HTTP returns 200 locally"   bash -c "curl -s -o /dev/null -w '%{http_code}' http://localhost | grep -q 200"
check "Internet reachable (ping)"  ping -c 1 -W 2 8.8.8.8
check "DNS resolves"               bash -c "getent hosts google.com"

echo
echo "Passed: $PASS  Failed: $FAIL"
echo "VM IP: $(hostname -I | awk '{print $1}')"
[[ $FAIL -eq 0 ]]
