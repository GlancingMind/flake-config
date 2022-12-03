{ pkgs, lib, config, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    homeDirectory ="/home/sascha";
    stateVersion = "22.11";
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

  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  home.packages = with pkgs; [
    smartmontools
    unzip zip
    poppler_utils pandoc texlive.combined.scheme-small #for pandoc
    zotero
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
