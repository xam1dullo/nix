{ pkgs, ... }: {
  # Prettier terminal prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # settings = {
    #   battery.disabled = true;
    # };
    settings = {
      format = ''
        $directory
        $character
      '';
      add_newline = true;
      package = {
        disabled = true;
      };
    };
  };
}
