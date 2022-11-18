{ pkgs, config, ... }:

{
  # New option in home-manager 22.11
  #programs.bashmount.enable = true;

  home.packages = with pkgs; [
    jmtpfs android-file-transfer go-mtpfs libusb1
    bashmount
  ];

  home.sessionVariables = {
    # Unclutter home-directory
    ANDROID_HOME = "${config.xdg.dataHome}/android";
  };
}
