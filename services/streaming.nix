{ pkgs, ...}:
{
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  # This will create a virtual camera device
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 video_nr=0 card_label="VirtualCam"
  '';
  # NOTE This is required for obs-studio. In OBS version 26, this might be no
  # longer needed.
  boot.kernelModules = ["v4l2loopback"];
}
