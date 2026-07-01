{...}: {
  # Home Manager owns ~/.zshrc (starship, compinit, plugins). Without this,
  # nix-darwin's /etc/zshrc runs prompt suse + compinit before every HM shell.
  programs.zsh = {
    enable = true;
    promptInit = "";
    enableCompletion = false;
    enableGlobalCompInit = false;
    enableBashCompletion = false;
  };
}
