{
  description = "My first nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , stylix
    , zen-browser
    , ...
    } @ inputs:
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

      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        });
    in
    {

      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      overlays = import ./overlays { inherit inputs; };

      nixosModules = import ./modules/nixos;

      homeManagerModules = import ./modules/home-manager;

      # NixOS configurations
      nixosConfigurations = {

        khamidullo = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            # Main nixos configuration file
            ./nixos/configuration.nix
          ];
        };
      };

      # Home Manager configurations
      homeConfigurations = {
        "khamidullo@nix" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
          modules = [
            ./home-manager/home.nix
          ];
        };
      };

      # homeConfigurations = {
      #   "khamidullo@nix" = home-manager.lib.homeManagerConfiguration {
      #     pkgs = import nixpkgs {
      #       system = "x86_64-linux";
      #       config.allowUnfree = true;
      #     };
      #     system = "x86_64-linux";
      #     homeDirectory = "/home/khamidullo";
      #     username = "khamidullo";
      #     extraSpecialArgs = { inherit inputs; };
      #     # specialArgs = { inherit inputs; };
      #     modules = [ ./home-manager/home.nix ];
      #   };
      # };

      # homeManagerConfigurations = {
      #   khamidullo = home-manager.lib.homeManagerConfiguration {
      #     pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
      #     system = "x86_64-linux";
      #     homeDirectory = "/home/khamidullo";
      #     username = "khamidullo";
      #     specialArgs = { inherit inputs; };
      #     modules = [
      #       # Main home-manager configuration file
      #       ./home-manager/home.nix
      #     ];
      #   };
      # };
    };
}
