{ pkgs, ... }:
with pkgs;
[
  # General packages for development and system management
  aspell
  aspellDicts.en
  bash-completion
  coreutils
  killall
  neofetch
  openssh
  sqlite
  wget
  zip
  unzip
  unrar
  lnav
  devbox

  # Rust-rewritten CLI tools
  bat
  btop
  eza
  fd
  fzf
  gping
  hyperfine
  procs
  ripgrep
  tree

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2
  bundletool

  # Cloud-related tools and SDKs
  docker_29
  docker-compose
  google-cloud-sdk

  # Media-related packages
  ffmpeg

  # Node.js development tools
  nodePackages.prettier
  nodePackages.jsdoc
  nodejs
  pnpm

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jq
  tmux
  zsh-powerlevel10k
  texliveFull

  # Python packages
  python3
  virtualenv

  # AI coding agents
  (aider-chat.overridePythonAttrs (_: {
    doCheck = false;
  }))

  # Nix related
  nil
  nixd
  nixpkgs-fmt
  nixfmt

  wakatime-cli
]
