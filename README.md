# my approach in getting blazingly fast

this repo mostly contains nixos related configs to all my machines. heavily inspired from [orzklv/nix](https://github.com/orzklv/nix) and [dustinlyons/nixos-config](https://github.com/dustinlyons/nixos-config)

## How to rebuild macOS (Pro)

Use flake mode explicitly; do not rely on legacy `NIX_PATH`/`<darwin>` lookups.

```bash
# from repo root
darwin-rebuild build --flake .#Pro
sudo darwin-rebuild switch --flake .#Pro
```

Rollback options:

```bash
# profile rollback (fastest)
sudo darwin-rebuild switch --rollback

# flake rollback to a previous commit/state
git checkout <previous-commit>
sudo darwin-rebuild switch --flake .#Pro
```

`darwin-rebuild edit` is currently broken with Nix 2.31.x in legacy mode
(`nix-instantiate --no-out-link`). Use this repo helper instead:

```bash
./scripts/darwin-pro edit
```

## How to rebuild Linux (dreampad)

Run these on the Linux host:

```bash
sudo nixos-rebuild switch --flake .#dreampad
# or build only:
nixos-rebuild build --flake .#dreampad
```

## Reproducibility note (dirty git tree)

If the working tree is dirty, Nix warns and builds from your uncommitted snapshot.
That is valid locally, but less reproducible for rollback/sharing because it does
not map to a clean commit.

```bash
git status --short
git add -A && git commit -m "nix: update config"
```
