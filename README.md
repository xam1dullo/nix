# my approach in getting blazingly fast

this repo mostly contains nixos related configs to all my machines. heavily inspired from [orzklv/nix](https://github.com/orzklv/nix) and [dustinlyons/nixos-config](https://github.com/dustinlyons/nixos-config)

## Neovim on Darwin (Home Manager + nix-darwin)

Neovim is managed declaratively with Home Manager through:

- `modules/home-manager/neovim.nix`
- `nvim/` (repo-managed Lua config, linked to `~/.config/nvim`)

This setup targets stable Neovim from your pinned `nixpkgs` and avoids nightly/experimental Neovim features so it stays aligned with the stable [Neovim roadmap direction](https://neovim.io/roadmap/).

### Rebuild

```bash
./scripts/darwin-pro build --dry-run
sudo darwin-rebuild switch --flake /Users/admin/blazingly-fast#Pro
```

### Config location

- Source of truth: `/Users/admin/blazingly-fast/nvim`
- Runtime path linked by Home Manager: `~/.config/nvim`

### What is configured

- LSP: TypeScript, ESLint, Lua, Nix, Docker, JSON, YAML, Bash, SQL, Haskell
- Formatting: Prettier, Stylua, Alejandra, Fourmolu/Ormolu
- Treesitter: TS/TSX/JS/JSON/Lua/Nix/Haskell/SQL/Dockerfile/YAML/TOML/Markdown
- Debugging: `nvim-dap` + `vscode-js-debug` for Node/TypeScript/React
- Copilot: `copilot.lua` with explicit insert-mode keymaps
- UX: Telescope, which-key, lualine, Oil, gitsigns, fugitive

### Verify setup

1. Verify Neovim package version from flake:

```bash
nix eval --raw .#darwinConfigurations.pro.pkgs.neovim.version
```

Expected: prints a stable Neovim version string.

2. Verify config link target after switch:

```bash
readlink ~/.config/nvim
```

Expected: points to a Home Manager-managed path sourced from this repo.

3. Open Neovim and sync plugins:

```bash
nvim +Lazy!\\ sync +qa
```

Expected: lazy.nvim installs plugins without errors.

4. LSP checks inside Neovim:

```vim
:LspInfo
```

Expected attached servers depending on filetype (for example `ts_ls/tsserver`, `eslint`, `lua_ls`, `nixd`, `dockerls`, `jsonls`, `yamlls`, `bashls`, `sqls`, `hls`).

5. Treesitter checks inside Neovim:

```vim
:TSInstallInfo
```

Expected required parsers are installed and `highlight` is enabled.

6. DAP checks inside a JS/TS file:

- `<leader>db` toggle breakpoint
- `<leader>dc` start/continue
- `<leader>du` toggle dap-ui

Expected: `js-debug` adapter starts and breakpoints are hit in launch/attach configs.

7. Copilot checks:

```vim
:Copilot status
```

Expected: Copilot reports ready/authenticated. Insert-mode keys:

- `<C-l>` accept suggestion
- `<M-n>` next suggestion
- `<M-p>` previous suggestion
- `<C-]>` dismiss suggestion

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
