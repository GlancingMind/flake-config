{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    flake-compat = {
      url = github:edolstra/flake-compat;
      flake = false;
    };
    stable.url = github:NixOS/nixpkgs/nixos-21.11;
    unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    own.url = github:GlancingMind/nixpkgs/release-21.11;
    home-manager = {
      url = github:nix-community/home-manager/release-21.11;
      inputs.nixpkgs.follows = "stable";
    };
    customPkgs = {
      url = path:./packages/plugins/vim;
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = { self, flake-compat, flake-utils, customPkgs, home-manager, stable, unstable, own }:
  let
    system = "x86_64-linux";
    stablePkgs = import stable { inherit system; };
    unstablePkgs = import unstable { inherit system; };
    ownPkgs = import own { inherit system; };
    lib = stable.lib;
  in {
    devShell.${system} = stablePkgs.mkShell {
      name = "system-setup-shell";

      buildInputs = [
        stablePkgs.git # required by flake
        stablePkgs.gnumake
        stablePkgs.rnix-lsp
        stablePkgs.esh
        (stablePkgs.writeScriptBin "nixFlakes" ''
            #!/usr/bin/env bash
            exec ${stablePkgs.nixFlakes}/bin/nix \
            --experimental-features "nix-command flakes" "$@"
        '')
        (stablePkgs.nixos { nix.package = stablePkgs.nixFlakes; }).nixos-rebuild
      ];
    };

    overlays = {
      packages = final: prev: customPkgs.packages."x86_64-linux";
    };

    nixosConfigurations = let
      specialArgs = {
        hardware = import ./hardware;
        services = import ./services;
      };
    in {
      laptop = lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = [
          ./systems/laptop
          ./users/sascha
          {
            nixpkgs.overlays = [
              (final: prev: {
                packages = self.overlays.packages final prev;
                inherit unstablePkgs;
              })
            ];
          }
          home-manager.nixosModules.home-manager
        ];
      };
    };

    apps."x86_64-linux".repl = let
      repl = stablePkgs.writeShellScriptBin "repl" ''
          confnix=$(mktemp)
          echo "builtins.getFlake (toString $(git rev-parse --show-toplevel))" >$confnix
          trap "rm $confnix" EXIT
          nix repl $confnix
      '';
    in {
      type = "app";
      program = "${toString repl}/bin/repl";
    };

    laptop = self.nixosConfigurations.laptop.config.system.build.toplevel;
  };
}
