{ pkgs, ... }:

{
  programs.tmux.enable = true;
  programs.foot.enable = true;
  programs.alacritty.enable = true;

  imports = [
    ./tmux.nix
    ./foot.nix
    ./alacritty.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    # Move into dedicated dev-shell
    hledger hledger-ui
    gitAndTools.git-annex lsof #lsof is required for git-annex webapp

    cachix
    htop
    xdg_utils
    remind
    glow

    viddy dasel
    # Bulk find and replace
    vgrep amber fastmod sd sad
    ripgrep
    # Code stats
    scc
    # Code doc
    dasht zeal

    yt-dlp ytfzf
    viu fbida

    zk
    tmpmail
    twtxt
  ];
}
