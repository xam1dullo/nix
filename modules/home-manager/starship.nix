_: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      command_timeout = 2000;
      battery.disabled = true;
    };
  };
}
