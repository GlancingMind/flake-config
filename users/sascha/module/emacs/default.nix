{ config, pkgs, lib, ... }:

let
in
{
  # Don't forget to use services.emacs...
  programs.emacs = {
    enable = true;
  };

  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
  ];

  xdg.configFile."emacs/init.el".source =
    lib.mkIf (config.programs.emacs.enable) ./init.el;
}
