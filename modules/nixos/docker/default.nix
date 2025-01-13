{pkgs, ...}: let
  # Import the unstable Nixpkgs package set
  unstablePkgs =
    import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
      sha256 = "01f1ym9f0dr66yg6d2fzapscrd0dh125zpi04wp0b2l32v57nxq8"; # Replace with actual sha256
    })
    {
      inherit (pkgs) system;
      config = {
        allowUnfree = true;
      };
    };
in {
  networking.firewall.trustedInterfaces = ["docker0"];

  virtualisation = {
    docker = {
      enable = true;
      # use nvidia as the default runtime
      enableNvidia = true;
      extraOptions = "--default-runtime=nvidia";
      autoPrune = {

        enable = true;
        dates = "daily";
      };
    };
  };

  hardware.nvidia-container-toolkit.enable = true;

  environment = {
    systemPackages = (with unstablePkgs; [
      docker-compose
      docker
    ]);

    shellAliases = {
      dka = "docker kill $(docker ps -qa) 2> /dev/null";
      dra = "docker rm -f $(docker ps -qa) 2> /dev/null";
      dkra = "dka; dra";
      dria = "docker rmi -f $(docker image ls -qa)";
      dils = "docker image ls";
      dcp = "docker cp";
      dps = "docker ps -a";
      dl = "docker logs";
      ld = "lazydocker";
    };
  };
}
