{
  description = "blazingly fast nix config";
  inputs = {
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    determinate,
    nixos-hardware,
    home-manager,
    nix-darwin,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      formatter = pkgs.alejandra;
      devShells.default = pkgs.callPackage ./shell.nix {};
    })
    // (let
      lib = nixpkgs.lib // home-manager.lib // (import ./lib);
      specialArgs = {
        inherit inputs lib;
        modules = import ./modules;
      };
    in let
      dreampadNixos = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          determinate.nixosModules.default
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen6
          home-manager.nixosModules.home-manager
          ./hosts/linux/dreampad/configuration.nix
        ];
      };
      proDarwin = nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = [
          determinate.darwinModules.default
          home-manager.darwinModules.home-manager
          ./hosts/darwin/Pro
        ];
        system = "aarch64-darwin";
      };
    in {
      nixosConfigurations.dreampad = dreampadNixos;
      darwinConfigurations = {
        # Canonical host key is lowercase; keep Pro alias for compatibility.
        pro = proDarwin;
        Pro = proDarwin;
      };
      packages = {
        aarch64-darwin = {
          darwin-pro = proDarwin.config.system.build.toplevel;
        };
        x86_64-linux = {
          nixos-dreampad = dreampadNixos.config.system.build.toplevel;
        };
      };
      checks = {
        aarch64-darwin = {
          darwin-pro = proDarwin.config.system.build.toplevel;
        };
        x86_64-linux = {
          nixos-dreampad = dreampadNixos.config.system.build.toplevel;
        };
      };
    });
}
