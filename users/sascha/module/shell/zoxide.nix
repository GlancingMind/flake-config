{ pkgs, ... }:
{
  home.packages = [
    pkgs.fzf # Required by zoxide
  ];
}
