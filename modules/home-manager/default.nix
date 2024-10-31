{
  # List your module files here
  git = import ./git;
  zsh = import ./zsh;
  helix = import ./helix;
  nixpkgs = import ./nixpkgs;
  terminal = import ./terminal;
  tmux = import ./tmux;
  packages = import ./packages;
  vscode = import ./vscode;
  pipewire = import ./pipewire;
  postgres = import ./postgres;
  utils = import ./utils;
  cli = import ./cli;
}
