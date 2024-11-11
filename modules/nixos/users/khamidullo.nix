{ pkgs, ... }: {
  config = {

    users = {
      defaultUserShell = pkgs.zsh;
      users = {

        khamidullo = {
          isNormalUser = true;
          description = "Khamidullo khudoyberdiyev";
          initialPassword = "1532";
          extraGroups = [
            "wheel"
            "video"
            "networkmanager"
            "docker"
            "audio"
            "git"
            "input"
            "systemd-journal"

          ];
          packages = (with pkgs;[
            telegram-desktop
            github-desktop
            # spotify
          ]) ++ (with pkgs.unstable; [
            zed-editor
          ]);
        };
      };
    };
  };


  # home-manager = {
  #   extraSpecialArgs = { inherit inputs outputs; };
  #   users = {
  #     # Import your home-manager configuration
  #     khamidullo = import ../../../home-manager/home.nixs;
  #   };
  # };
}
