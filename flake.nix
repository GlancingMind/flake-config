{
  description = "A very basic flake";

  inputs = {
    stable.url = github:NixOS/nixpkgs/nixos-22.05;
    home-manager = {
      url = github:nix-community/home-manager/release-22.05;
      inputs.nixpkgs.follows = "stable";
    };
    unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    customPkgs = {
      url = path:./packages/plugins/vim;
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = { self, home-manager, stable, unstable, customPkgs }:
    let
      system = "x86_64-linux";
      stablePkgs = stable.legacyPackages.${system};
      unstablePkgs = unstable.legacyPackages.${system};
    in {
      devShells.${system} = {
        default = stablePkgs.callPackage ./shell.nix {};
      };

      nixosConfigurations = {
        laptop = stable.lib.nixosSystem {
          inherit system;
          specialArgs = {
            hardware = import ./hardware;
            services = import ./services;
          };
          modules = [
            ./systems/laptop
            ./users/sascha
            {
              # Pin nixpkgs. So "nix run nixpkgs#<package>" will use the
              # pinned version.
              nix.registry.nixpkgs.flake = stable;
              nixpkgs.overlays = [
                (final: prev: {
                  packages = customPkgs.packages.${system};
                  inherit unstablePkgs;
                })
              ];
            }
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };

}
