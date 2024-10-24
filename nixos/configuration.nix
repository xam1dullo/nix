# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ]; # Agar NVIDIA video drayverlari kerak bo'lsa
      xkb = {
        layout = "us";
        variant = "";
      };

      # Exclude some defautl packages
      excludePackages = [ pkgs.xterm ];
    };

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoLogin.enable = true;
        autoLogin.user = "pro";
      };
    };

    desktopManager = {
      plasma6.enable = true;
    };

    envfs.enable = true;
    blueman.enable = true;

    printing.enable = true; # CUPS ni yoqing

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      audio.enable = true;
      # jack.enable = true; # JACK ilovalari uchun
      # Agar media-session kerak bo'lsa:
      # media-session.enable = true;
    };
  };
  # GPU for docker containers
  hardware.nvidia-container-toolkit.enable = true;

  # Kernel mod for nvidia laptops
  boot.kernelParams = [
    "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1"
  ];
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.khamidullo = {
    isNormalUser = true;
    description = "khamidullo";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      # kate
      thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;



  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      nil
      nixd
      nixpkgs-fmt

      firefox
      google-chrome

      vim
      wget
      alacritty
      tmux
      neovim
      git
      zsh
      tree
      obsidian
      fzf
      nodejs
      vscode

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

    ];

    #  ) ++ (with pkgs.unstable; [
    #	   zed-editor
    #	   vscode
    #	   postman
    #
    #	   nodejs_22
    #	   pnpm
    #
    # ]);
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
  # home-manager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programsmtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  # Driver + parameters
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # Don't ask for sudo password
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
