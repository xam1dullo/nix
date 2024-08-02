{ pkgs
, inputs
, outputs
, lib
, config
, packages
, ...
}: {
  config = {
    users.users = {
      pro = {
        isNormalUser = true;
        description = "Khamidullo Khudoyberdiev";
        initialPassword = "1532";
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC0KeEt90SP6fnt1xqNVQadwqtmiPBUKM0pi+mW5OXM5gDjulP2V+GC6GoQ7vqSO8eTEoi9HUib2BjuY7T9fl7SA1iT18b7N3J9gZ28sxtr6LkhRcAmuded/+Rdg0fmyOS9Z7XGyKC916wsdvphjdKOzQcSZxTOj89sDYHQy/U1+0AreYcMFqx+94DG7gkyjFKTxebsCuRm1VoqgPaqxFXO8KyiHe7vPNgmCFw50bNTb55avxKVOi1L4x8YLTJPHRBde3axz/iD9L+0ZA8X0XKcJGtekFIzHp/Zr2ahxpl64PaenItRK1FoREG+v2/Ug8H2qn+v7yAdV2Q37iTIYaEd/DxeEYHic+KOgpJmj5RAiMgXlB0rDxhobvcbU+kf90d64DngT7W8aogDCLkmqfCxQ4W5QzrX5IUGYj4VwaxTkYpVhYqJPjWrTbR4pJsNsMf2lYGix1sY1VdWtmoH5lF+XW3tJuYmuP1GEoaUjbYO6lDjY2CA+/ST0NFaZen8YB7L0iguOaJ6V33tR9HfmfxtEmfUtWcUbET1YVny0cX7HY6BMTAr8cZcNFWrd9Ti4DD7SyF/pewGXWtd6DgI9Ds6vFwk/qKD3Q26/klx5/JPm7XJR5wsLOabtqiV1KxuQ/yMtyGocEijAArBsp/U4+RDXfY/7rOTPh1VLoULda3wOw== khkhamidullo@gmail.com"
        ];
        extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" "admins" ];
        packages =
          (with pkgs; [
            telegram-desktop
            github-desktop
            spotify
            discord
          ])
          ++ (with pkgs.unstable; [ ]);
      };
    };

    home-manager = {
      extraSpecialArgs = { inherit inputs outputs; };
      users = {
        # Import your home-manager configuration
        pro = import ../../../home/linux.nix;
      };
    };
  };
}
