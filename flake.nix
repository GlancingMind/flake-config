{
  description = "A very basic flake";

  inputs = {
    stable.url = github:NixOS/nixpkgs/nixos-21.05;
    unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager/release-21.05;
      inputs.nixpkgs.follows = "stable";
    };
    customPkgs = {
      url = path:./packages/plugins/vim;
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = { self, customPkgs, home-manager, stable, unstable }: {
    overlays = {
      packages = final: prev: customPkgs.packages."x86_64-linux";
    };

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
          {
            nixpkgs.overlays = [
              (final: prev: {
                packages = self.overlays.packages final prev;
                unstable = import unstable { system = "x86_64-linux"; };
              })
            ];
          }
          home-manager.nixosModules.home-manager
        ];
      };
    };

    laptop = self.nixosConfigurations.laptop.config.system.build.toplevel;

    apps."x86_64-linux".repl = let
      pkgs = import stable { system = "x86_64-linux"; };
      repl = pkgs.writeShellScriptBin "repl" ''
        confnix=$(mktemp)
        echo "builtins.getFlake (toString $(git rev-parse --show-toplevel))" >$confnix
        trap "rm $confnix" EXIT
        nix repl $confnix
      '';
    in {
      type = "app";
      program = "${toString repl}/bin/repl";
    };
  };
}
