{ username, ...}:
{
  nix.settings.trusted-users = [
    username
  ];

  nix.settings = {
    substituters = [
      "https://ros.cachix.org"
      "https://nix-community.cachix.org"
      "https://glancingmind.cachix.org"
    ];
    trusted-public-keys = [
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "glancingmind.cachix.org-1:FyFTWB9dixh0wjmhRGzqZDu5bCmhVlWdszIipVT/5vU="
    ];
  };
}
