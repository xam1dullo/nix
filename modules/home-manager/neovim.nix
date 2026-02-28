{pkgs, lib, ...}: let
  neovimToolchain = with pkgs; [
    neovim

    # Core CLI tooling
    ripgrep
    fd
    fzf
    git
    jq
    tree-sitter
    lazygit
    lazydocker

    # Node / TS
    nodejs_20
    pnpm_10
    nodePackages.typescript
    nodePackages.prettier
    nodePackages.typescript-language-server
    vscode-langservers-extracted
    nodePackages.bash-language-server
    nodePackages.yaml-language-server

    # Containers
    docker
    docker-compose
    dockerfile-language-server

    # SQL
    pgcli
    sqls

    # Nix
    nixd
    nil
    alejandra

    # Lua / Haskell formatters + tooling
    stylua
    fourmolu
    ormolu
    ghc
    cabal-install
    hlint
    haskell-language-server

    # LSP / DAP runtime binaries
    lua-language-server
    vscode-js-debug
  ];
in
  lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      package = pkgs.neovim;
    };

    home.packages = neovimToolchain;

    # Keep Neovim config in-repo for reproducibility.
    xdg.configFile."nvim" = {
      source = ../../nvim;
      recursive = true;
    };
  }
