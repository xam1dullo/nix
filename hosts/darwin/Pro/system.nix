{
  pkgs,
  ...
}: let
  kmonad = pkgs.kmonad;
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
