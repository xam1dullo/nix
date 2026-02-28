_: {
  home = {
    enableNixpkgsReleaseCheck = false;
    stateVersion = "25.11";
  };

  targets.darwin.copyApps.enable = false;
  # Keep copies disabled to avoid drift, but expose GUI apps via symlinks.
  targets.darwin.linkApps.enable = true;

  # Marked broken Oct 20, 2022 check later to remove this
  # https://github.com/nix-community/home-manager/issues/3344
  # manual.manpages.enable = false;
}
