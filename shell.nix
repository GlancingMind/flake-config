let
  pkgs = import (builtins.fetchTarball {
    name = "nixos-20.09";
    url = "https://github.com/NixOS/nixpkgs/archive/0cfd08f4881bbfdaa57e68835b923d4290588d98.tar.gz";
    sha256 = "1srd9p37jmrsxgvrxvlibmscphz5p42244285yc5piacvrz1rdcc";
  }) {};
in pkgs.stdenv.mkDerivation {
  name = "system-setup-shell";

  buildInputs = [
    pkgs.gnumake
    pkgs.vim
    pkgs.git # required by flake
    (pkgs.writeScriptBin "nixFlakes" ''
      #!/usr/bin/env bash
      exec ${pkgs.nixFlakes}/bin/nix \
        --experimental-features "nix-command flakes" "$@"
    '')
    (pkgs.nixos { nix.package = pkgs.nixFlakes; }).nixos-rebuild
  ];
}
