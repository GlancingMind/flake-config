{ pkgs, hardware, ...}:
{
  imports = [
    ./hardware-configuration.nix
    (hardware.ssd)
    (hardware.x220)
  ];

  # NOTE using pkgs.nixFlakes will break autocompletion for nix...
  # but using the normal nix version will result in unkown option flag and
  # not using this config will result in a warning when a specific nix-flake
  # package is used...
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # NOTE installs nix with flake support as separate command
  environment.systemPackages = [
    (pkgs.writeScriptBin "nixflk" ''
      #!/usr/bin/env bash
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}
