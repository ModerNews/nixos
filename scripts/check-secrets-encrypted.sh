#!/usr/bin/env bash
# pre-commit hook: refuse a secrets/*.yaml that isn't sops-encrypted
# (no top-level `sops:` metadata block).
set -euo pipefail

status=0
for f in "$@"; do
  if ! grep -q "^sops:" "$f"; then
    echo "not sops-encrypted: $f" >&2
    status=1
  fi
done
exit "$status"
