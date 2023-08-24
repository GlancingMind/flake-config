{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    AusweisApp2
  ];

  networking.firewall = let
    ausweisapp2-port = [ 24727 ];
  in {
    allowedTCPPorts = ausweisapp2-port;
    allowedUDPPorts = ausweisapp2-port;
  };
}
