{pkgs, ...}: {
  home.packages = [pkgs.starship];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      command_timeout = 200;
      nix_shell.disabled = true;
      battery.disabled = true;
    };
  };
}
