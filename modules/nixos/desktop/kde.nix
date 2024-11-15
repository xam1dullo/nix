# =================================
# For further configuration extention, please refer to:
# https://wiki.nixos.org/wiki/KDE
# =================================
{ pkgs, ... }: {
  config = {
    # Enable the X11 windowing system.
    services = {

      # Enable the GDM display manager.
      displayManager = {
        # defaultSession = "none+i3";
        autoLogin.enable = true;
        autoLogin.user = "pro";
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };

      # Enable the KDE Desktop Environment.
      desktopManager.plasma6 = {
        enable = true;
      };

      xserver = {
        enable = true;
        # Configure keymap in X11
        xkb = {
          variant = "";
          layout = "us";
        };

        # Exclude some defautl packages
        excludePackages = [ pkgs.xterm ];


        # envfs.enable = true;
        # blueman.enable = true;

        # printing.enable = true; # CUPS ni yoqing

      };
    };

    qt = {
      enable = true;
      platformTheme = "kde";
      style = "breeze";
    };



    # Exclude some packages from the KDE desktop environment.
    environment.plasma6.excludePackages =
      with pkgs.kdePackages; [
        kate # that editor
        plasma-browser-integration # browser integration
        # helix
      ];

    
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    # Enable the DConf configuration system.
    programs.dconf.enable = true;

    # Additional packs for customization.
    environment.systemPackages = with pkgs; [
      # Papirus Icon Pack
      papirus-icon-theme
    ];
  };
}
