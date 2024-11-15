# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ config, pkgs, inputs, ... }: {
  # You can import other home-manager modules herecolor-schemes
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # inputs.self.homeManagerModules.example
    inputs.self.homeManagerModules.zsh
    inputs.self.homeManagerModules.git
    inputs.self.homeManagerModules.terminal
    inputs.self.homeManagerModules.nixpkgs
    inputs.self.homeManagerModules.tmux
    inputs.self.homeManagerModules.vscode
    # inputs.self.homeManagerModules.topgrade
    inputs.self.homeManagerModules.packages
    inputs.self.homeManagerModules.pipewire
    inputs.self.homeManagerModules.cli
    inputs.self.homeManagerModules.helix

    # inputs.self.homeManagerModules.utils


    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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

  home = {
    username = "khamidullo";
    homeDirectory = "/home/khamidullo";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Home 🏛Namangan International school xususiy maktabi Janubiy Koreya universitetlari bilan hamkorlik boshlamoqda.Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
    ".config/wezterm".source = ../config/wezterm;
    # ".config/skhd".source = ~/dotfiles/skhd;
    # ".config/starship".source = ~/dotfiles/starship;
    # ".config/zellij".source = ~/dotfiles/zellij;
    # ".config/nvim".source = ~/dotfiles/nvim;
    # ".config/nix".source = ~/dotfiles/nix;
    # ".config/nix-darwin".source = ~/dotfiles/nix-darwin;
    # ".config/tmux".source = ~/dotfiles/tmux;
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.direnv.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";


  # powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
