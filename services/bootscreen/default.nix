{ pkgs, hardware, ...}:
{
  # Settings for silent booting
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 3;
  boot.kernelParams = [
    "quiet"
    "udev.log_priority=3"
  ];
  boot.initrd.kernelModules = [
    "i915"
  ];

  # Boot splash
  boot.plymouth = let
    cat-theme = pkgs.callPackage ./cat.nix {};
  in {
    enable = true;
    theme = cat-theme.pname;
    themePackages = [
      cat-theme
    ];
  };
}
