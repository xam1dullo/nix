{
  lib,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = lib.mkMerge [
        (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
        (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 14)
      ];
      cursor-style = "block";
      window-padding-x = 2;
      window-padding-y = 2;
      macos-option-as-alt = true;

      # Gruvbox Material theme
      background = "282828";
      foreground = "d4be98";
      palette = [
        "0=#3c3836"
        "1=#ea6962"
        "2=#a9b665"
        "3=#d8a657"
        "4=#7daea3"
        "5=#d3869b"
        "6=#89b482"
        "7=#d4be98"
        "8=#3c3836"
        "9=#ea6962"
        "10=#a9b665"
        "11=#d8a657"
        "12=#7daea3"
        "13=#d3869b"
        "14=#89b482"
        "15=#d4be98"
      ];
    };
  };
}
