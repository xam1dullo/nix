{ pkgs, ... }: {
  config = {
    fonts.packages = with pkgs; [
      noto-fonts
      # noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      berkeley-mono-typeface # It is here!
      berkeley-mono-typeface # It is here!
      (nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      })
    ];
  };
}
