{ pkgs, hardware, services, ...}:
{
  imports = [
    ./hardware-configuration.nix
    (hardware.ssd)
    (hardware.x220)
    (services.bootscreen)
  ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      # Enable sandboxing for nixpkg contribution
      sandbox = true;
      # Hardlink identical files together
      auto-optimise-store = true;
    };
  };

  # Clean /tmp directory on boot
  boot.tmp.cleanOnBoot = true;

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
  system.stateVersion = "22.11"; # Did you read the comment?
}
