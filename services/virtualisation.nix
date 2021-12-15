{ username, ...}:
{
  # must add user to libvirtd and docker group
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Docker
  #virtualisation.docker.enable = false;
  #users.users."${username}".extraGroups = [ "docker" ];

  # Qemu, libvirt, vagrant
  #virtualisation.libvirtd.enable = true;
  #services.qemuGuest.enable = true;
  #services.nfs.server.enable = true;

  #users.users."${username}".extraGroups = [ "libvirtd" ];

  ## Open ports in the firewall.
  #networking.firewall = let
  #  vagrant.nfs.ports = [ 111 2049 20048 ];
  #in {
  #  allowedTCPPorts = vagrant.nfs.ports;
  #  allowedUDPPorts = vagrant.nfs.ports;
  #};
}
