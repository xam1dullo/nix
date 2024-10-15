{ pkgs, ... }: {
  config = {

    users = {
      defaultUserShell = pkgs.zsh;
      users = {

        khamidullo = {
          isNormalUser = true;
          description = "Khamidullo khudoyberdiyev";
          initialPassword = "1532";
          extraGroups = [ "networkmanager" "wheel" "docker" ];
          packages = with pkgs; [
            # kate
            thunderbird
            vscode
            telegram-desktop
            git
            libreoffice-fresh
            firefox
            google-chrome
            gcc
            fastfetch
            btop
            unstable.zed-editor

          ];
        };
      };
    };
  };
}
