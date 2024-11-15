# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs
, lib
, config
, pkgs
, ...
}:

{
  imports =
    [

      inputs.self.nixosModules.ssh
      inputs.self.nixosModules.zsh
      inputs.self.nixosModules.fonts
      inputs.self.nixosModules.sound
      inputs.self.nixosModules.nixpkgs
      inputs.self.nixosModules.users.khamidullo
      inputs.self.nixosModules.desktop.kde
      # inputs.self.nixosModules.hardware
      inputs.self.nixosModules.nix-ld
      inputs.self.nixosModules.docker
      # inputs.homeManagerModules.postgresa

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

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



  # Enable sound with pipewire.
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.


  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
  # home-manager.pipewire.enable = true;

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
  };

  # Driver + parameters
  # Don't ask for sudo password

  security.sudo.wheelNeedsPassword = false;
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_16;
      ensureDatabases = [ "b1_db" ];
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all      all                    trust
        host  all      all     127.0.0.1/32   trust
        host  all      all     ::1/128        trust
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
        CREATE DATABASE nixcloud;
        GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
      '';
    };

    # mongodb = {
    #   enable = true;

    auto-cpufreq.enable = true;
    nginx.enable = true;
  };

  # services.pgadmin = {
  #   enable = true;
  #   initialEmail = "khkhamidullo@gmail.com";
  #   initialPasswordFile = "/var/lib/pgadmin/initial-password"; # Define this file
  #   # port = 5432;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
