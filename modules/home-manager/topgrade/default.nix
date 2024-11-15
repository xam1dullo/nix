{ pkgs, ... }:
let
  # Don't update home manager on NixOS
  duhm =
    if pkgs.stdenv.isDarwin
    then [ ]
    else [ "home_manager" ];

  # Disable updates for these programs
  dull = [
    "bun"
    "nix"
    "node"
    "pnpm"
    "yarn"
    "cargo"
    "vscode"
  ];
in
{
  config = {
    programs.topgrade = {
      enable = true;
      settings = {
        misc = {
          disable = dull ++ duhm;
          no_retry = true;
          assume_yes = true;
          no_self_update = true;
        };
        commands = { };
        linux = {
          nix_arguments = "--flake github:xam1dullo/nix";
          home_manager_arguments = [ "--flake" "github:xam1dullo/nix" ];
        };
        brew = {
          autoremove = true;
        };
      };
    };
  };
}
lambdajon/confs