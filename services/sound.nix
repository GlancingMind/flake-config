{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    apulse
  ];

  sound.enable = true;
  # TODO when enabled be sure to install apulse too!
  # can conditianally install like so.
  # pkgs.lib.optional (pulseaudio ? enable -> pulseaudio.enable) pkgs.apulse
  hardware.pulseaudio.enable = true;
}
