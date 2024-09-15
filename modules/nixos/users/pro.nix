{ pkgs, ... }: let 
    globalPackages = import ../../../home-manager/home.nix { inherit pkgs; };
in {
  config = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.pro = {
      isNormalUser = true;
      description = "Khamidullo";
      initialPassword = "1532";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = (with pkgs; [
        thunderbird
        firefox
      ]) ++ globalPackages;
    };
  };
}
