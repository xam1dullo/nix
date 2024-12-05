{
  description = "My first nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

   # zen
    zen-browser = {
       url = "github:MarceColl/zen-browser-flake";
     };
    
  };

  outputs =
    { self
    , nixpkgs#
    , home-manager
    , zen-browser
    , nixpkgs-unstable
    , ...
    } @ inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;

      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems = lib.genAttrs systems;
      # forAllSystems = nixpkgs.lib.genAttrs systems;



      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});


      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });

      # Define a development shell for each system
      devShellFor = system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        import ./shell.nix { inherit pkgs; };

    in
    {

      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);


      overlays = import ./overlays { inherit inputs; };


      nixosModules = import ./modules/nixos;


      homeManagerModules = import ./modules/home;


      # Available through 'nixos-rebuild --flake .#nixos'
      nixosConfigurations = {


        khamidullo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos configuration file <
            ./nixos/configuration.nix
          ];
        };
      };


      # Available through 'home-manager --flake .#rshohruh@nixos'
      homeConfigurations = {

        "khamidullo@nix" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };

          modules = [
            # > Our main home-manager configuration file <

            ./home-manager/home.nix
          ];
        };
      };
    };
}

# {
#   description = "My first nix config";

#   inputs = {
#     # Nixpkgs
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

#     nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
#     # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

#     # Home manager
#     home-manager.url = "github:nix-community/home-manager/release-24.11";
#     home-manager.inputs.nixpkgs.follows = "nixpkgs";


#     # zen
#     zen-browser = {
#        url = "github:MarceColl/zen-browser-flake";
#      };
#   };

#   outputs =
#     { self
#     , nixpkgs
#     , home-manager
#     ,zen-browser
#     ,nixpkgs-unstable
#     , ...
#     } @ inputs:
#     let
#       inherit (self) outputs;

#       lib = nixpkgs.lib // home-manager.lib;

#       systems = [
#              "aarch64-linux"
#              "i686-linux"
#              "x86_64-linux"
#              "aarch64-darwin"
#              "x86_64-darwin"
#       ];

#       forAllSystems = nixpkgs.lib.genAttrs systems;


#       forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});


#       pkgsFor = lib.genAttrs systems (system:
#         import nixpkgs {
#           inherit system;
#           config.allowUnfree = true;
#         });


#     in
#     {

#       packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

#       formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);


#       overlays = import ./overlays { inherit inputs; };


#       nixosModules = import ./modules/nixos;


#       homeManagerModules = import ./modules/home;


#       # NixOS configurations
#            nixosConfigurations = {

#              khamidullo = nixpkgs.lib.nixosSystem {
#                system = "x86_64-linux";
#                specialArgs = {
#                     inherit inputs outputs;
#                };
#                modules = [
#                  # Main nixos configuration file
#                  ./nixos/configuration.nix
#                ];
#              };
#            };

#            # Home Manager configurations
#            homeConfigurations = {
#              "khamidullo@nix" = home-manager.lib.homeManagerConfiguration {
#                pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
#                modules = [
#                  ./home-manager/home.nix
#                ];
#              };
#            };
#       # # Available through 'nixos-rebuild --flake .#nixos'
#       # nixosConfigurations = {

#       #   khamidullo = nixpkgs.lib.nixosSystem {
#       #     specialArgs = { inherit inputs outputs; };
#       #     modules = [
#       #       # > Our main nixos configuration file <
#       #       ./nixos/configuration.nix
#       #     ];
#       #   };
#       # };


#       # # Available through 'home-manager --flake .#rshohruh@nixos'
#       # homeConfigurations = {

#       #   "khamidullo@nix" = home-manager.lib.homeManagerConfiguration {
#       #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
#       #     extraSpecialArgs = { inherit inputs outputs; };
#       #     modules = [
#       #       # > Our main home-manager configuration file <
#       #       ./home-manager/home.nix
#       #     ];
#       #   };
#       # };
#     };
# }
