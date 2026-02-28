{
  configurations = import ./configurations;
  home-manager = import ./home-manager;
  nix = import ./nix;
  packages = import ./packages;
  packagesHomebrew = import ./packages/homebrew.nix;
  users = import ./users;
}
