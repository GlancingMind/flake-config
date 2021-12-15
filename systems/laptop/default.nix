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
    # Hardlink identical files together
    autoOptimiseStore = true;
    # Enable sandboxing for nixpkg contribution
    useSandbox = true;
  };

  # NOTE installs nix with flake support as separate command
  environment.systemPackages = [
    (pkgs.writeScriptBin "nixflk" ''
      #!/usr/bin/env bash
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
  ];

  # Clean /tmp directory on boot
  boot.cleanTmpDir = true;

  powerManagement.cpuFreqGovernor = "ondemand";

  # Limit the systemd journal to 100 MB of disk or the last 7 days of logs,
  # whichever happens first.
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    MaxFileSec=7day
  '';

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}
