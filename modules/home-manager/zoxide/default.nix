{ pkgs, ... }: {

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };
}
