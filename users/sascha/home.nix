{ pkgs, lib, config, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    homeDirectory ="/home/sascha";
    stateVersion = "23.05";
  };

  imports = [
    ./role/wayland
    ./module/terminal
    ./module/editors
    ./module/shell
    ./module/mounting
    ./module/multimedia/streaming
    ./module/multimedia/video-player
    ./module/password-manager
  ];

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://ros.cachix.org"
      "https://nix-community.cachix.org"
      "https://glancingmind.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "glancingmind.cachix.org-1:FyFTWB9dixh0wjmhRGzqZDu5bCmhVlWdszIipVT/5vU="
    ];
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  home.packages = with pkgs; [
    smartmontools
    unzip zip
    poppler_utils pandoc texlive.combined.scheme-small #for pandoc
    zotero openconnect
    fd
    xdg-ninja
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    signing = {
      # Signing key for my public commits and repos.
      key = "0x6958F57B10911518";
    };
    delta = {
      enable = true;
      options = {
        syntax-theme="gruvbox-light";
      };
    };
    extraConfig = {
      pull.ff = "only";
      init.defaultBranch = "main";
    };
  };
}
