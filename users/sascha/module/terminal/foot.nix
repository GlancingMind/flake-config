{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FantasqueSansMono"
      ];
    })
    fantasque-sans-mono

    lsix # List images via sixel
  ];
  # Allow discoverability of fonts installed via home.packages
  fonts.fontconfig.enable = true;

  programs.foot = {
    settings = {
      # See: https://codeberg.org/dnkl/foot/src/branch/master/doc/foot.ini.5.scd
      # And: https://codeberg.org/dnkl/foot/src/branch/master/foot.ini
      # for configuration.
      main = {
        shell = lib.getExe pkgs.tmux;
        term = "xterm-256color";
        font = "FantasqueSansMono:size=11";
        dpi-aware = "no";
        pad = "0x0 center";
      };

      colors = {
        # hard contrast: background = '0xf9f5d7';
        background = "0xfbf1c7";
        # soft contrast: background = '0xf2e5bc';
        foreground = "0x3c3836";

        regular0 = "0xfbf1c7"; # black
        regular1 = "0xcc241d"; # red
        regular2 = "0x98971a"; # green
        regular3 = "0xd79921"; # yellow
        regular4 = "0x458588"; # blue
        regular5 = "0xb16286"; # magenta
        regular6 = "0x689d6a"; # cyan
        regular7 = "0x7c6f64"; # white

        bright0 = "0x928374"; # bright black
        bright1 = "0x9d0006"; # bright red
        bright2 = "0x79740e"; # bright green
        bright3 = "0xb57614"; # bright yellow
        bright4 = "0x076678"; # bright blue
        bright5 = "0x8f3f71"; # bright magenta
        bright6 = "0x427b58"; # bright cyan
        bright7 = "0x3c3836"; # bright white
        # 16 = "..."
        # ...
        # 255 = "..."
        # selection-foreground=<inverse foreground/background>
        # selection-background=<inverse foreground/background>
        # jump-labels=<regular0> <regular3>
        # urls=<regular3>
      };
    };
  };
}
