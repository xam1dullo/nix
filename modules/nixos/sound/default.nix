{ pkgs, ... }: {
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment thishttps://www.totaltypescript.com/buy
    # jack.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;
  security.polkit.enable = true;
  # environment.systemPackages = with pkgs; [ pulseaudioFull ];
}

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
