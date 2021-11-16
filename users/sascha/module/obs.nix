{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = pkgs.unstablePkgs.obs-studio;
    plugins = [ pkgs.obs-wlrobs pkgs.obs-v4l2sink ];
  };
}
