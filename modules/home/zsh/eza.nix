{ pkgs, ... }: {
  # Prettier terminal prompt
  programs.eza = {
    enable = true;
    icons = "auto";
    enableZshIntegration = true;
  };
}
