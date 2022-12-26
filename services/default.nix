{
  bootscreen = import ./bootscreen;
  login-manager = import ./login-manager.nix;
  caches = import ./caches.nix;
  bluetooth = import ./bluetooth.nix;
  sound = import ./sound.nix;
  networking = import ./networking.nix;
  virtualisation = import ./virtualisation.nix;
  development = import ./development.nix;
  localisation = import ./localisation.nix;
  mounting = import ./mounting.nix;
  printing = import ./printing.nix;
  streaming = import ./streaming.nix;
  ssh = import ./ssh.nix;
}
