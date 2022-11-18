{ pkgs, ...}:

{
  imports = [
    ./firefox.nix
    #./chromium.nix
  ];

  home.packages = with pkgs; [
    w3m
  ];
}
