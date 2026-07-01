#!/usr/bin/env bash
# Kechroq ishga tushirish uchun: Pro (darwin) hostni build+switch qilish.
set -euo pipefail

cd "$(dirname "$0")"

echo "== nix build (darwin toplevel) =="
nix build --no-update-lock-file --no-link .#darwinConfigurations.pro.config.system.build.toplevel

echo "== darwin-rebuild switch =="
sudo darwin-rebuild switch --flake .#pro
