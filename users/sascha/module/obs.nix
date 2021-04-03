{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-wlrobs pkgs.obs-v4l2sink ];
  };
}
