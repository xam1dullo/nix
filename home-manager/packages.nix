{ pkgs }:
(with pkgs; [
  nil
  nixd
  nixpkgs-fmt

  firefox
  google-chrome

  thunderbird
  libsForQt5.kleopatra

  tree
  git

  steam
  heroic
  prismlauncher

  spotify
  obsidian
  anytype
  onlyoffice-bin_latest

  obs-studio
  vlc

  python3
  jetbrains-toolbox
  texturepacker

  telegram-desktop
  element-desktop
  zulip

  webkitgtk_6_0

  _1password-gui
  termius
  bruno

  virtualenv
  htop
  inetutils

  llvmPackages.llvm
  llvmPackages.clang
  cmake
  alacritty
  tmux
  neovim
  zsh
  fzf
  bluez
  bluez-tools
#  bluez-utils

  # home manager
  home-manager
  starship
  gh
  # cc
  gcc
  clang
  cl
  zig
  bat
  unzip
  insomnia
  github-desktop
  zoxide
]) ++ (with pkgs.unstable; [
  zed-editor
  vscode
  discord
  postman
  
  nodejs_22
  pnpm
])
