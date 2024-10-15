# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:

{
  imports =
    [


      outputs.nixosModules.users.khamidullo
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };
      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };



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

  # enable direnv
  programs.direnv.enable = true;


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
      # defaultSession = "none+i3";
      autoLogin.enable = true;
      autoLogin.user = "pro";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    desktopManager = {
      # xterm.enable = false;
      plasma6.enable = true;
    };


    envfs.enable = true;
    # blueman.enable = true;

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
  hardware = {
    pulseaudio.enable = false;
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
  # Enable sound with pipewire.
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
  };

  programs = {
    zsh.enable = true;
    firefox.enable = true;
    # floorp.enable = true;
  };


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
  # Driver + parameters
  # Don't ask for sudo password
  security =
    {
      rtkit.enable = true;
      sudo.wheelNeedsPassword = false;
    };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
