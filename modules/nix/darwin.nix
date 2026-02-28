{
  inputs,
  lib,
  ...
}: {
  nix.enable = false;

  # Determinate manages Nix settings in /etc/nix/nix.custom.conf.
  determinate-nix.customSettings = {
    # Keep this to features supported by your installed Nix version.
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Ensure the canonical nix.conf exists and includes Determinate's generated settings.
  environment.etc."nix/nix.conf".text = ''
    include /etc/nix/nix.custom.conf
  '';

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
      android_sdk.accept_license = true;
    };

    overlays = [
      inputs.nur.overlays.default
    ];
  };
}
