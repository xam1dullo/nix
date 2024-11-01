{ color-schemes, ... }:

{
  programs.ghostty = {
    enable = true;
    shellIntegration.enable = false;
    shellIntegration.enableZshIntegration = true;
    settings = {
      font-size = 11;
      font-family = "JetBrainsMono Nerd Font";

      # The default is a bit intense for my liking
      # but it looks good with some themes
      unfocused-split-opacity = 0.96;

      # Some macOS settings
      window-theme = "dark";
      macos-option-as-alt = true;

      # Disables ligatures
      font-feature = [ "-liga" "-dlig" "-calt" ];
      config-file = [
        (color-schemes + "/Ghostty/GruvboxDark")
      ];
    };

  };
}
