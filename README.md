# nixos

- test.flake.nix
```nix

{
  description = "My first nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    lib = nixpkgs.lib // home-manager.lib;

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = lib.genAttrs systems;

    # Define pkgsFor using the nixpkgs input
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          # Include your overlays here if needed
          # e.g., (import ./overlays/default.nix { inherit inputs; })
        ];
      }
    );

    # Define unstablePkgsFor using the nixpkgs-unstable input
    unstablePkgsFor = lib.genAttrs systems (system:
      import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      }
    );

    # Define a development shell for each system
    devShellFor = system:
      import ./shell.nix {
        pkgs = pkgsFor.${system};
      };

  in
  {
    # Packages for each system
    packages = forAllSystems (system:
      import ./pkgs pkgsFor.${system}
    );

    # Formatter using Alejandra from nixpkgs-unstable
    formatter = forAllSystems (system:
      unstablePkgsFor.${system}.alejandra
    );

    # Overlays (if any)
    overlays = import ./overlays { inherit inputs; };

    # NixOS modules
    nixosModules = import ./modules/nixos;

    # Home Manager modules
    homeManagerModules = import ./modules/home-manager;

    # NixOS configurations
    nixosConfigurations = {
      khamidullo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    # Home Manager configurations
    homeConfigurations = {
      "khamidullo@nix" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor."x86_64-linux";
        extraSpecialArgs = { inherit inputs; };

        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}



```
