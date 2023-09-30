{ username, pkgs, ...}:
{
  services.udev.packages = [
    #enable mounting of android devices as unprivileged users without globally
    #running adb. See https://nixos.wiki/wiki/Android
    pkgs.android-udev-rules
  ];

  #programs.adb.enable = true;
  #users.users."${username}".extraGroups = [ "adbusers" ];

  # Enable NTFS-3G to allow mounting of ntfs formatted usb stick.
  boot.supportedFilesystems = ["ntfs"];

  services.udisks2 = {
    enable = true;
    # Mount in /media/ instead of /run/media/$USER/
    mountOnMedia = true;
  };
}
