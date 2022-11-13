{ config, lib, pkgs, ...}:
let
  glenda-wallpaper = builtins.fetchurl {
    url = https://9p.io/plan9/img/spaceglenda300.jpg;
    sha256 = "1d16z1ralcvif6clyn244w08wypbvag1hrwi68jbdpv24x0r2vfg";
  };
in
{
  #nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    grim slurp swappy
    qt5.qtwayland
    source-code-pro
    pulseaudio # required to use pactl for media keys
    firefox-wayland
    wdisplays
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."i3status".source = ../../program/status/i3status;

  home.sessionVariables = {
    TERM = "alacritty";
    BROWSER = "firefox";

    # enable wayland support for firefox
    MOZ_ENABLE_WAYLAND = "1";

    # needs qt5.qtwayland in systemPackages
    QT_QPA_PLATFORM = "wayland;xcb"; # if wayland doesn't work fall back to x
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd_hrgb";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "BEMENU_BACKEND=wayland ${pkgs.bemenu}/bin/bemenu-run -m 1 -i";
      input = {
        "*" = {
          xkb_layout = "de";
          xkb_model = "pc105";
          xkb_variant = "nodeadkeys";
          xkb_options = "caps:ctrl_modifier";
        };
      };
      keybindings = let
        brightnessctl = lib.getExe pkgs.brightnessctl;
        playerctl = lib.getExe pkgs.playerctl;
      in lib.mkOptionDefault {
        "XF86MonBrightnessUp" = "exec ${brightnessctl} set 10%+";
        "XF86MonBrightnessDown" = " exec ${brightnessctl} set 10%-";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +3%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -3%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86AudioPlay" = "exec ${playerctl} play-pause";
        "XF86AudioStop" = "exec ${playerctl} stop";
        "XF86AudioNext" = "exec ${playerctl} next";
        "XF86AudioPrev" = "exec ${playerctl} previous";
      };
      output = {
        "*" = {
          bg = "${glenda-wallpaper} fit #ffffff";
        };
        VGA-1 = {
          resolution = "1600x900";
          position = "0,0";
        };
        LVDS-1 = {
          resolution = "1366x768";
          position = "0,900";
        };
      };
      bars = [
        rec {
          id = "system-stats";
          mode = "hide";
          position = "bottom";
          statusCommand = "${lib.getExe pkgs.i3status}";
          fonts = {
            names = [ "Monospace" "SourceCodePro" ];
            size = 8.0;
          };
          extraConfig = ''
            ${id} gaps 5
          '';
        }
      ];
    };
  };
}
