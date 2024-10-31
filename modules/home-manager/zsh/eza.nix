{ pkgs, ... }: {
  # Prettier terminal prompt
  programs.eza = {
    enable = true;
    icons = true;
    enableZshIntegration = true;
  };
}
