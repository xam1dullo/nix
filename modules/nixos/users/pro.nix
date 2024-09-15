{ pkgs, ... }: {
  config = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.pro = {
      isNormalUser = true;
      description = "Khamidullo";
      initialPassword = "1532";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        thunderbird
        firefox
      ];
    };
  };
}
