{
  lib,
  pkgs,
  modules,
  ...
} @ args: let
  user = "admin";
  name = "khamidullo"; # Update with your name
  email = "khkhamidullo@gmail.com"; # Update with your email
in
  lib.mkMerge [
    {
      AstroNvim = {
        enable = true;
        username = user;
      };

      home-manager.users.${user} = lib.recursiveUpdate (modules.home-manager args) {
        programs.git = {
          settings.user = {
            inherit name email;
          };

          signing = {
            signByDefault = false;
          };
        };
      };
    }

    # NixOS
    (lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      users.users.${user} = {
        isNormalUser = true;
        description = "Admin";
        extraGroups = ["networkmanager" "wheel" "docker"];
        shell = lib.getExe pkgs.zsh;
      };
    })

    # nix-darwin
    (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      users.knownUsers = [user];
      users.users.${user} = {
        uid = 501;
        name = "${user}";
        home = "/Users/${user}";
        isHidden = false;
        shell = pkgs.zsh;
      };
    })
  ]
