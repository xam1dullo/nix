#!/usr/bin/env just --working-directory ./ --justfile

default:
    @just --list

format:
    nix fmt --pretty .

check:
    nix flake check

update:
    nix flake update

eval-pro:
    nix eval .#darwinConfigurations.pro.config.system.build.toplevel.drvPath --show-trace

eval-dreampad:
    nix eval .#nixosConfigurations.dreampad.config.system.build.toplevel.drvPath --show-trace

eval: eval-pro

switch-pro:
    sudo darwin-rebuild switch --flake .#pro

switch-dreampad:
    @command -v nixos-rebuild >/dev/null 2>&1 || { echo "nixos-rebuild not found — run this ON the dreampad NixOS host (darwin can't build a NixOS closure locally)"; exit 1; }
    sudo nixos-rebuild switch --flake .#dreampad
