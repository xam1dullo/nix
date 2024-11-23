{ pkgs, inputs, ... }:
let
  system = pkgs.system;
in
{
  config = {
    users = {
      defaultUserShell = pkgs.zsh;
      groups = {
        khamidullo = { }; # Create a group for the user
      };
      users = {
        khamidullo = {
          description = "Khamidullo Khudoyberdiyev";
          isNormalUser = true; # Keep this for a regular user
          group = "khamidullo"; # Assign the user to their own group
          initialPassword = "$6$jFUth6wTyXWPQojj$70.DBga9iBzBUAoPHvLAgnviwU6sjZRm9VpzINkQKtBNX3w8bNr/zxr3kHw2VFN/CWIttgTYU1B.X4EQUrgGv1";
          extraGroups = [
            "wheel"
            "video"
            "networkmanager"
            "docker"
            "audio"
            "git"
            "input"
            "systemd-journal"
          ];
          packages = (with pkgs; [
            telegram-desktop
            github-desktop
            inputs.zen-browser.packages."${system}".default
          ]) ++ (with pkgs.unstable; [
            zed-editor
          ]);
        };
      };
    };
  };

}
