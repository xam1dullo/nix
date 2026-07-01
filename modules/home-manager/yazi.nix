{pkgs, ...}: {
  programs.zoxide = {
    enable = true;
    # HM's zsh integration inits too early (before mkAfter content/plugins),
    # so chpwd_functions ends up with zoxide's hook non-last -> _ZO_DOCTOR
    # warning (nix-community/home-manager#9349). Real init happens at the
    # end of modules/home-manager/zsh/default.nix instead.
    enableZshIntegration = false;
    options = ["--cmd" "cd"];
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    extraPackages = with pkgs; [
      ffmpegthumbnailer
      jq
      poppler
      fd
      ripgrep
    ];
    settings = {
      mgr = {
        show_hidden = false;
        sort_by = "natural";
        sort_dir_first = true;
      };
      preview = {
        max_width = 1200;
        max_height = 1800;
      };
    };
  };
}
