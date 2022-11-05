{ pkgs, ... }:
{
  home.packages = [
    pkgs.fzf
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
