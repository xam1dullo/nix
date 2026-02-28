{lib, ...}: {
  home-manager.users.admin.programs.fzf.enable = lib.mkDefault true;
  home-manager.users.admin.programs.zsh.enableCompletion = lib.mkDefault true;
  home-manager.users.admin.programs.zsh.autosuggestion.enable = lib.mkDefault true;
  home-manager.users.admin.programs.zsh.syntaxHighlighting.enable = lib.mkDefault true;
}
