{pkgs, ...}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
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
