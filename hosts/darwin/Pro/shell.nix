{lib, ...}: {
  home-manager.users.admin = {
    programs.fzf.enable = lib.mkDefault true;
    programs.zsh = {
      enableCompletion = lib.mkDefault true;
      autosuggestion.enable = lib.mkDefault true;
      syntaxHighlighting.enable = lib.mkDefault true;
    };
  };
}
