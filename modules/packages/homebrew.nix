_: {
  homebrew = {
    enable = true;
    brews = [
      "doctl"
      "beads"
    ];
    casks = [
      # Development Tools
      "ghostty"
      "visual-studio-code"
      "zed"
      "postman"
      "termius"
      "proxyman"
      "utm"

      # Communication Tools
      "telegram"

      # Utility Tools
      # "syncthing"
      "obsidian"
      "wakatime"
      "font-jetbrains-mono-nerd-font"

      # Entertainment Tools
      "vlc"
      "obs"

      # Productivity Tools
      "raycast"

      # Browsers
      "google-chrome"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      extraFlags = [ "--force-cleanup" ];
      upgrade = true;
    };

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)

    masApps = {
      # "1password" = 1333542190;
      # Xcode = 497799835;
      # RunCat = 1429033973;
    };
  };
}
