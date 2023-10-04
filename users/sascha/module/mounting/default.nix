{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    jmtpfs android-file-transfer go-mtpfs libusb1
  ];

  home.sessionVariables = {
    # Unclutter home-directory
    ANDROID_HOME = "${config.xdg.dataHome}/android";
  };

  programs.bashmount.enable = true;

  services.udiskie = {
    enable = true;
    notify = false;
    tray = "never";
  };
}
