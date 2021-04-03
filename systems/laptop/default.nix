{ pkgs, hardware, ...}:
{
  imports = [
    ./hardware-configuration.nix
    (hardware.ssd)
    (hardware.x220)
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}
