{ config, pkgs, ... }:

let
  # Import the unstable Nixpkgs package set
  unstablePkgs = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
      # You can pin to a specific commit for reproducibility:
      # url = "https://github.com/NixOS/nixpkgs/archive/<commit-hash>.tar.gz";
    })
    {
      inherit (pkgs) system;
      config = {
        allowUnfree = true;
      };
    };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [
    ./zsh
    ./app.nix
    ./terminal
    ./packages
    # ./vscode
    ./git
  ];
  nixpkgs.config = {
    allowUnfree = true;
    nixpkgs.config = {
      allowUnfree = true;
    };

  };

  home.username = "khamidullo";
  home.homeDirectory = "/home/khamidullo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    # Add your stable packages here
    # Example:
    # git

    pgcli

  ]) ++ (with unstablePkgs; [
    # Add your unstable packages here
    zed-editor
    vscode
    discord
    postman
    nodejs_22
    pnpm
    floorp
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })

  ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/khamidullo/etc/profile.d/hm-session-vars.sh
  #


  # programs.helix = {
  #   enable = true;

  #   settings = {
  #     theme = "autumn_night";

  #     editor = {
  #       line-number = "relative";

  #       cursor-shape = {
  #         insert = "bar";
  #         normal = "block";
  #         select = "underline";
  #       };

  #       file-picker = {
  #         hidden = false;
  #         git-ignore = true;
  #         git-global = true;
  #       };

  #       lsp = {
  #         enable = true;
  #         display-messages = true;
  #         display-inlay-hints = true;
  #       };

  #       statusline = {
  #         left = [ "mode" "spinner" "read-only-indicator" "file-modification-indicator" ];

  #         center = [ "file-name" ];

  #         right = [
  #           "diagnostics"
  #           "selections"
  #           "position"
  #           "file-encoding"
  #           "file-line-ending"
  #           "file-type"
  #         ];

  #         separator = "│";

  #         mode = {
  #           normal = "SLAVE";
  #           insert = "MASTER";
  #           select = "DUNGEON";
  #         };
  #       };
  #     };

  #     keys.normal = {
  #       # Easy window movement
  #       "C-left" = "jump_view_left";
  #       "C-right" = "jump_view_right";
  #       "C-up" = "jump_view_up";
  #       "C-down" = "jump_view_down";

  #       "C-r" = ":reload";
  #     };
  #   };

  #   extraPackages = with pkgs;
  #     [
  #       #-- c/c++
  #       cmake
  #       cmake-language-server
  #       gnumake
  #       checkmake
  #       gcc # c/c++ compiler, required by nvim-treesitter!
  #       llvmPackages.clang-unwrapped # c/c++ tools with clang-tools such as clangd
  #       lldb

  #       #-- rust
  #       rust-analyzer
  #       cargo # rust package manager
  #       rustfmt

  #       #-- zig
  #       zls

  #       #-- nix
  #       nil
  #       nixd
  #       nixpkgs-fmt
  #       nixpkgs-lint

  #       # nixd
  #       statix # Lints and suggestions for the nix programming language
  #       deadnix # Find and remove unused code in .nix source files
  #       alejandra # Nix Code Formatter

  #       #-- golang
  #       go
  #       gomodifytags
  #       iferr # generate error handling code for go
  #       impl # generate function implementation for go
  #       gotools # contains tools like: godoc, goimports, etc.
  #       gopls # go language server
  #       delve # go debugger

  #       # -- java
  #       jdk17
  #       gradle
  #       maven
  #       spring-boot-cli

  #       #-- lua
  #       stylua
  #       lua-language-server

  #       #-- bash
  #       nodePackages.bash-language-server
  #       shellcheck
  #       shfmt

  #       #-- javascript/typescript --#
  #       nodePackages.nodejs
  #       nodePackages.typescript
  #       nodePackages.typescript-language-server
  #       # HTML/CSS/JSON/ESLint language servers extracted from vscode
  #       nodePackages.vscode-langservers-extracted
  #       nodePackages."@tailwindcss/language-server"

  #       #-- CloudNative
  #       nodePackages.dockerfile-language-server-nodejs
  #       emmet-ls
  #       jsonnet
  #       jsonnet-language-server
  #       hadolint # Dockerfile linter

  #       #-- Others
  #       taplo # TOML language server / formatter / validator
  #       nodePackages.yaml-language-server
  #       sqlfluff # SQL linter
  #       actionlint # GitHub Actions linter
  #       buf # protoc plugin for linting and formatting
  #       proselint # English prose linter
  #       guile # scheme language

  #       #-- Misc
  #       tree-sitter # common language parser/highlighter
  #       nodePackages.prettier # common code formatter
  #       marksman # language server for markdown
  #       glow # markdown previewer
  #       fzf

  #       #-- Optional Requirements:
  #       gdu # disk usage analyzer
  #       ripgrep # fast search tool
  #       docker
  #       floorp
  #     ]
  #     ++ (
  #       if pkgs.stdenv.isDarwin
  #       then [ ]
  #       else [
  #         #-- verilog / systemverilog
  #         verible
  #         gdb
  #       ]
  #     );
  # };


  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.enableNixpkgsReleaseCheck = false;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
