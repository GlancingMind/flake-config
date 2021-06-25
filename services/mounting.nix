{ username, pkgs, ...}:
{
  services.udev.packages = [
    #enable mounting of android devices as unprivileged users without globally
    #running adb. See https://nixos.wiki/wiki/Android
    pkgs.android-udev-rules
  ];

  users.users."${username}".extraGroups = [ "adbusers" ];

  # Enable NTFS-3G to allow mounting of ntfs formatted usb stick.
  boot.supportedFilesystems = ["ntfs"];
}
