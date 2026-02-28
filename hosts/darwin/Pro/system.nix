{
  inputs,
  pkgs,
  ...
}: let
  kmonad = inputs.kmonad.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  networking.hostName = "pro";

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
