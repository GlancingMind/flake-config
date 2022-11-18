{ pkgs, lib, config, ... }:

let
  own-neovim = pkgs.packages.neovim;
in {
  home.packages = [
    own-neovim
    # pkgs.vis
    # pkgs.ed
  ];

  home.sessionVariables = {
    EDITOR = lib.getExe own-neovim;
    VISUAL = lib.getExe own-neovim;
  };
}
