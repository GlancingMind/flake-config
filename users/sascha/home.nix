{ pkgs, lib, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./role/wayland/sway.nix
    #./role/x11/i3.nix
    #./module/mail/generated/mail.nix
    #./module/surfraw.nix
    ./module/shell/shell.nix
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
        "application/pdf" = "org.pwmt.zathura.desktop";

        "x-scheme-handler/chrome" = "firefox.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
      };
    };
  };

  home.homeDirectory ="/home/sascha";
  #home.username = "$USER";

  home.packages = with pkgs; [
    dasht zeal
    glow
    nix-du graphviz
    pavucontrol
    htop unzip dash
    xdg_utils
    jmtpfs android-file-transfer go-mtpfs libusb1
    gitAndTools.git-bug
    gitAndTools.git-annex lsof #lsof is required for git-annex webapp
    reno
    hledger hledger-ui
    w3m
    #libvirt vagrant podman-compose #docker-compose
    gnumake
    vis dvtm abduco #as Vim and Tmux alternative
    zathura poppler_utils pandoc texlive.combined.scheme-small #for pandoc
    zotero zk
    #chromium
    fselect
    peco viddy dasel
    vgrep delta amber fastmod sd sad
    scc ripgrep ugrep
    youtube-dl yt-dlp ytfzf viu mps-youtube
    zip
    vimiv-qt imv gimp
    cachix
    remind
    fbida libsixel lsix
    tmpmail
    ed
    twtxt
    wdisplays
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
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
      init.defaultBranch = "main";
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
