{lib, ...}: {
  home-manager.users.admin = {
    programs.git.settings = {
      fetch.prune = true;
      rerere.enabled = true;
    };

    programs.delta = {
      enable = lib.mkDefault true;
      enableGitIntegration = true;
    };
  };
}
