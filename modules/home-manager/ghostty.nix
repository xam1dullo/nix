{
  lib,
  pkgs,
  ...
}: {
  # ghostty installed via homebrew cask; config managed here
  xdg.configFile."ghostty/config".text = let
    fontSize =
      if pkgs.stdenv.hostPlatform.isDarwin
      then "14"
      else "10";
  in ''
    command = /bin/zsh -l
    font-family = JetBrainsMono Nerd Font
    font-size = ${fontSize}
    cursor-style = block
    window-padding-x = 2
    window-padding-y = 2
    macos-option-as-alt = true

    # Gruvbox Material theme
    background = 282828
    foreground = d4be98
    palette = 0=#3c3836
    palette = 1=#ea6962
    palette = 2=#a9b665
    palette = 3=#d8a657
    palette = 4=#7daea3
    palette = 5=#d3869b
    palette = 6=#89b482
    palette = 7=#d4be98
    palette = 8=#3c3836
    palette = 9=#ea6962
    palette = 10=#a9b665
    palette = 11=#d8a657
    palette = 12=#7daea3
    palette = 13=#d3869b
    palette = 14=#89b482
    palette = 15=#d4be98
  '';
}
