{ config, lib, pkgs, ...}:
let
  terminal = pkgs.alacritty;
in
{
  home.packages = with pkgs; [
    grim slurp swappy
    qt5.qtwayland
    source-code-pro
    pulseaudio # required to use pactl for media keys
    firefox-wayland
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."i3status".source = ./i3status;

  #TODO maybe replace with `sway.extraSessionCommands`?
  home.sessionVariables = {
    TERM = terminal.pname;
    BROWSER = lib.getExe pkgs.firefox;

    # enable wayland support for firefox
    MOZ_ENABLE_WAYLAND = "1";

    # needs qt5.qtwayland in systemPackages
    QT_QPA_PLATFORM = "wayland;xcb"; # if wayland doesn't work fall back to x
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd_hrgb";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

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
            setImage = "swww img --filter Nearest --transition-type center ${cream-soda-image}";
            cream-soda-image = builtins.fetchurl {
              name = "cream-soda.gif";
              url = "https://64.media.tumblr.com/16603c05db90e488eeabc4333d66255b/a9d3423d3756d30a-a4/s500x750/2f7ef1857938f9065d997f5c4c4edf62feb267ec.gifv";
              sha256 = "08fhcyfay3sb3ar7dfxszbnzkp6bnz1v02hkfwiv6a31nvkfm8q7";
            };
          in ''
            # Set background image when daemon is running.
            # Otherwise start daemon and set the image
            ${setImage} || ( swww init && ${setImage} )
          '';
        };
      in [
        { command = lib.getExe animated-desktop-background; always = true; }
      ];
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
