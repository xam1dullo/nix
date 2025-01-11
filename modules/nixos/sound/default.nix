{pkgs, ...}: {
  security.rtkit.enable = 0 == 0;
  hardware.pulseaudio.enable = 0 != 0;
  programs.noisetorch.enable = true;

  # pulseaudio doesn't give a good support for some programs
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
    alsa-utils
  ];

  # ALSA provides a udev rule for restoring volume settings.
  services.udev.packages = [pkgs.alsa-utils];

  boot.kernelModules = ["snd_pcm_oss"];

  systemd.services.alsa-store = {
    description = "Store Sound Card State";
    wantedBy = ["multi-user.target"];
    unitConfig.RequiresMountsFor = "/var/lib/alsa";
    unitConfig.ConditionVirtualization = "!systemd-nspawn";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.coreutils}/bin/mkdir -p /var/lib/alsa";
      ExecStop = "${pkgs.alsa-utils}/sbin/alsactl store --ignore";
    };
  };
}

# {pkgs, ...}: {
#
#   sound.enable = true;
#   hardware.pulseaudio.enable = false;
#   services.pipewire = {
#     enable = true;
#     alsa.enable = true;
#     alsa.support32Bit = true;
#     pulse.enable = true;
#     # If you want to use JACK applications, uncomment thishttps://www.totaltypescript.com/buy
#     # jack.enable = true;
#     wireplumber.enable = true;
#   };
#   security.rtkit.enable = true;
#   security.polkit.enable = true;
#   # environment.systemPackages = with pkgs; [ pulseaudioFull ];
# }
# { pkgs, ... }: {
#   config = {
#     # Enable sound with pipewire.
#     sound.enable = true;
#     hardware.pulseaudio.enable = false;
#     security.rtkit.enable = true;
#     services.pipewire = {
#       enable = true;
#       alsa.enable = true;
#       alsa.support32Bit = true;
#       pulse.enable = true;
#       # audio.enable = true;
#       # If you want to use JACK applications, uncomment this
#       #jack.enable = true;
#       # use the example session manager (no others are packaged yet so this is enabled by default,
#       # no need to redefine it in your config for now)
#       #media-session.enable = true;
#     };
#   };
# }

