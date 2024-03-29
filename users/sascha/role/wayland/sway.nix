{ config, lib, pkgs, ...}:
let
  terminal = pkgs.alacritty;
in
{
  home.packages = with pkgs; [
    grim slurp
    qt5.qtwayland
    source-code-pro
    pulseaudio # required to use pactl for media keys
    firefox-wayland
    swww
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."i3status".source = ./i3status;

  xdg.desktopEntries = {
    poweroff = {
      name = "poweroff";
      exec = "shutdown now";
    };
    reboot = {
      name = "reboot";
      exec = "systemctl reboot";
    };
    suspend = {
      name = "suspend";
      exec = "systemctl suspend";
    };
  };

  wayland.windowManager.sway = let
    application-launcher = pkgs.writeShellApplication {
      name = "application-launcher";
      runtimeInputs = with pkgs; [ bemenu j4-dmenu-desktop ];
      text = ''
        export BEMENU_BACKEND=wayland
        j4-dmenu-desktop --use-xdg-de --dmenu="bemenu -m 1 -i"
      '';
    };
  in {
    enable = true;
    xwayland = true;
    extraSessionCommands = ''
      export TERM=${terminal.pname}
      export BROWSER=${lib.getExe pkgs.firefox}

      # enable wayland support for firefox
      export MOZ_ENABLE_WAYLAND="1"

      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM="wayland;xcb"; # if wayland doesn't work fall back to x
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1";

      export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd_hrgb";
      export _JAVA_AWT_WM_NONREPARENTING="1";
    '';
    config = {
      modifier = "Mod4";
      terminal = lib.getExe terminal;
      menu = lib.getExe application-launcher;
      input = {
        "*" = {
          xkb_layout = "de";
          xkb_model = "pc105";
          xkb_variant = "nodeadkeys";
          xkb_options = "caps:ctrl_modifier";
        };
      };
      startup = let
        animated-desktop-background = pkgs.writeShellApplication {
          name = "animated-desktop-background";
          runtimeInputs = with pkgs; [ swww ];
          text = let
            setWallpaper = "swww img --filter Nearest --transition-type center ${wallpaper}";
            wallpaper = builtins.fetchurl {
              url = "https://i.pinimg.com/originals/19/6a/d9/196ad9d3122098b297d7b99ce9ff209f.gif";
              sha256 = "1mczxwxnvb02w9l6ps137p0sd2928crjf4njb211kw8ams3vzplk";
            };
          in ''
            # Set background image when daemon is running.
            # Otherwise start daemon and set the image
            (swww init && ${setWallpaper}) || ${setWallpaper}
          '';
        };
      in [
        { command = lib.getExe animated-desktop-background; always = true; }
      ];
      keybindings = let
        brightnessctl = lib.getExe pkgs.brightnessctl;
        playerctl = lib.getExe pkgs.playerctl;
        screenshot = lib.getExe pkgs.wayshot;
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
        "Print" = "exec ${screenshot}";
      };
      window = {
        titlebar = false;
      };
      output = {
        #"*" = let
        #  glenda-wallpaper = builtins.fetchurl {
        #    url = "https://9p.io/plan9/img/spaceglenda300.jpg";
        #    sha256 = "1d16z1ralcvif6clyn244w08wypbvag1hrwi68jbdpv24x0r2vfg";
        #  };
        #in {
        #  bg = "${glenda-wallpaper} fit #ffffff";
        #};
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
          statusCommand = lib.getExe pkgs.i3status;
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
