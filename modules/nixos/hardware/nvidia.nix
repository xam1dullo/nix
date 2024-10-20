{ config, pkgs, ... }:
{

  # GPU for docker containers

  hardware.pulseaudio.enable = false;


  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia-container-toolkit.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    nvidia = {
      open = false;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
  # Kernel mod for nvidia laptops
  boot.kernelParams = [
    "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1"
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

}
