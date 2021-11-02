{ pkgs, lib, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./role/wayland/sway.nix
    #./role/x11/i3.nix
    #./module/mail/generated/mail.nix
    #./module/surfraw.nix
    ./module/obs.nix
    #./module/editor/vim/vim.nix
    ./module/editor/vim/nvim.nix
    ./module/emacs
    ./module/tmux.nix
    ./module/video-player.nix
    ./module/shell/zsh/zsh.nix
    ./module/terminal/foot.nix
    ./module/terminal/alacritty/settings.nix
    ./module/password-manager/pass/password-store.nix
    #./module/irssi.nix
  ];

  xdg = {
    enable = true;
    userDirs.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };

  home.homeDirectory ="/home/sascha";
  #home.username = "$USER";

  home.packages = with pkgs; [
    pavucontrol
    htop unzip dash
    xdg_utils
    jmtpfs
    android-file-transfer
    gitAndTools.git-bug
    gitAndTools.git-annex lsof #lsof is required for git-annex webapp
    hledger hledger-ui
    w3m
    libvirt vagrant docker-compose
    gnumake
    vis dvtm abduco #as Vim and Tmux alternative
    zathura
    #chromium
    #vscodium
    fselect
    peco
    vgrep delta amber fastmod unstablePkgs.sad # sd sad
    #pistol
    #jetbrains.goland
    youtube-dl yt-dlp ytfzf
    zip
    imv gimp
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-light";
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
    };
  };

  # See all available envs here: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html
  #   - Setting of Browser and TERM is done by the respective "desktop" environment as wayland requires diffrent browser/terminal as x11
  # NOTE Maybe use:
  # - import or list package directly as dependency e.g. EDITOR = (import .../vim.nix)/bin/vim;
  # - mimeApps.defaultApplications."text/plain" = (import .../vim.nix);
  home.sessionVariables = rec {
    SHELL = "zsh";
    VISUAL = "vim";
    EDITOR = VISUAL;
    # use NIX recursive set as $VISUAL will be empty
    # because home-manager sorts variables and EDITOR
    # will be set before VISUAL is known.
  };
}
