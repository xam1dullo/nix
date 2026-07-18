{
  pkgs,
  ...
}: let
  kmonad = pkgs.kmonad;
in {
  networking.hostName = "pro";

  # NOTE: do not set launchd.envVariables.PATH here. Its `launchctl setenv`
  # is blocked by SIP ("Operation not permitted while System Integrity
  # Protection is engaged") and, because the activation script runs `set -e`,
  # it aborts activation before /run/current-system is even linked - taking
  # every system package off PATH. Shells get node & co. via the profile-path
  # fallback in modules/home-manager/zsh/default.nix instead.

  system = {
    stateVersion = 6;
    primaryUser = "admin";
  };

  environment.systemPackages = [
    kmonad
    (pkgs.writeScriptBin "kmonad-gallium" ''
      sudo ${kmonad}/bin/kmonad ${./keyboard.kbd}
    '')
  ];
}
