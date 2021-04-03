{
  description = "A very basic flake";

  inputs = {
    stable.url = github:NixOS/nixpkgs/nixos-20.09;
    unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager/release-20.09;
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = { self, home-manager, stable, unstable }: {
    nixosConfigurations = let
      specialArgs = {
        hardware = import ./hardware;
        services = import ./services;
      };
    in {
      laptop = stable.lib.nixosSystem {
        system = "x86_64-linux";
        inherit specialArgs;
        modules = [
          ./systems/laptop
          ./users/sascha
          ./users/test
          home-manager.nixosModules.home-manager
        ];
      };
    };

    laptop = self.nixosConfigurations.laptop.config.system.build.toplevel;
  };
}
