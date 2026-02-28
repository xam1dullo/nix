{
  inputs,
  lib,
  ...
}: {
  nix.enable = false;

  # Determinate manages Nix settings in /etc/nix/nix.custom.conf.
  determinate-nix.customSettings = {
    # Enables parallel evaluation (remove this setting or set the value to 1 to disable)
    eval-cores = 0;
    experimental-features = [
      "nix-command"
      "flakes"
      "build-time-fetch-tree" # Enables build-time flake inputs
      "parallel-eval" # Enables parallel evaluation
    ];
    # Other settings
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
