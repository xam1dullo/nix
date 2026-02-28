{
  modules,
  ...
}: {
  imports = [
    modules.configurations.darwin
    modules.nix.darwin
    modules.packages
    modules.packagesHomebrew
    modules.users.admin
    ./system.nix
    ./ui.nix
    ./devtools.nix
    ./shell.nix
    ./git.nix
    ./languages.nix
  ];
}
