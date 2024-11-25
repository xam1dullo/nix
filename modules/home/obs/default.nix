{ config, inputs, lib, pkgs, ... }:

let
  hostname = "nixos";
  installOn = [
    "khamidullo@nix"
    "vader"
  ];

in

lib.mkIf (lib.elem hostname installOn) {

  home = {
    file = {
      "${config.home.homeDirectory}/.config/obs-studio/.keep".text = "";
      "${config.home.homeDirectory}/.config/obs-studio/themes" = {
        recursive = true;
      };
    };

    packages = with pkgs; [
      obs-cli
      obs-cmd
    ];
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
