{
  description = "My first nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";


    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , zen-browser
    , ...
    } @ inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;{
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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, hyprland-plugins, nixvim, stylix, zen-browser, ... }:
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
        specialArgs = { inherit inputs; };
        modules = [
          # Main nixos configuration file
          ./nixos/configuration.nix
          nixvim.nixosModules.default
        ];
      };
    };

    # Home Manager configurations
    homeManagerConfigurations = {
      khamidullo = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
        system = "x86_64-linux";
        homeDirectory = "/home/khamidullo";
        username = "khamidullo";
        specialArgs = { inherit inputs; };
        modules = [
          # Main home-manager configuration file
          ./home-manager/home.nix
        ];
      };
    };
  };
}


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


      homeManagerModules = import ./modules/home-manager;


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
