{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = pkgs.unstablePkgs.obs-studio;
    plugins = [ pkgs.obs-wlrobs ];
  };
}
