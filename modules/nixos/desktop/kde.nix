# =================================
# For further configuration extention, please refer to:
# https://wiki.nixos.org/wiki/KDE
# =================================
{ pkgs, ... }:
let
  x86_64-opengl =
    if (!pkgs.stdenv.hostPlatform.isAarch64)
    then {
      driSupport32Bit = true;
    } else { };

  all-opengl = {
    enable = true;
    driSupport = true;
  };
in
{
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
        videoDrivers = [ "nvidia" ]; # Agar NVIDIA video drayverlari kerak bo'lsa

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

    # Make sure opengl is enabled
    hardware.opengl = all-opengl // x86_64-opengl;

    # Exclude some packages from the KDE desktop environment.
    environment.plasma6.excludePackages =
      with pkgs.kdePackages; [
        kate # that editor
        plasma-browser-integration # browser integration
      ];

    # Enable the DConf configuration system.
    programs.dconf.enable = true;


    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Additional packs for customization.
    environment.systemPackages = with pkgs; [
      # Papirus Icon Pack
      papirus-icon-theme
      nil
      nixd
      nixpkgs-fmt

      firefox
      google-chrome

      vim
      wget
      alacritty
      # tmux
      neovim
      git
      zsh
      tree
      obsidian
      fzf
      nodejs
      # vscode

      vlc
      obs-studio

      termius
      htop
      virtualenv



      bluez
      bluez-tools

      telegram-desktop
      # bluez-utils

      # home manager
      home-manager
      zoxide
      starship
      gh
      # cc
      gcc
      clang
      cl
      zig
      bat
      unzip
      insomnia

      github-desktop
      # Papirus Icon Pack
      papirus-icon-theme

      # Various plugins for KDE
      kdePackages.kdeconnect-kde
      kdePackages.plasma-browser-integration

      # X server video bridge
      vulkan-tools
      wayland-utils
      xwaylandvideobridge
      kdePackages.kdeconnect-kde
      kdePackages.plasma-browser-integration
      vulkan-tools
      wayland-utils
      wineWowPackages.waylandFull
      xwaylandvideobridge
      curl
      ffmpeg-full
      flameshot

      zulip-term
      keepassxc
      stacer
      baobab
      smartmontools
      flameshot
      libqalculate
      nfs-utils


      # Media
      moc
      yt-dlp
      feh
      imagemagick
      optipng
      peek

      auto-cpufreq
      zulip
      # Browser for at least searching something
      librewolf

      # Papirus Icon Pack
      papirus-icon-theme
    ];
  };
}
