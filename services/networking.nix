# NOTE: For networkd, iwd and resolved configuration see ArchWiki or
# https://insanity.industries/post/simple-networking/
{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    iwd
  ];

  networking.hostName = "thinkpad";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  networking.useNetworkd = true;
  systemd.network = {
    enable = true;
    networks = {
      "25-wireless" = {
        name = "wlan0";
        DHCP = "yes";
        #networkConfig = {
        #  IPv6PrivacyExtensions = true;
        #};
        #dhcpConfig = {
        #  Anonymize = true;
        #};
      };
      "20-wired" = {
        enable = false;
        name = "en*";
        DHCP = "yes";
        #networkConfig = {
        #  IPv6PrivacyExtensions = true;
        #};
        #dhcpConfig = {
        #  Anonymize = true;
        #};
      };
    };
  };
  services.resolved.enable = true;

  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        # Produce following errors for `systemctl status iwd`
        # resolve-systemd: Failed to modify the DNS entries. org.freedesktop.resolve1.LinkBusy: Link wlan0 is managed.
        # resolve-systemd: Failed to modify the domains entries. org.freedesktop.resolve1.LinkBusy: Link wlan0 is managed.
        EnableNetworkConfiguration = false;
        AddressRandomization = "network";
      };
      #Settings = {
      #  AlwaysRadomizeAddress = true;
      #};
    };
  };

  systemd.services.iwd-config = {
    enable = true;
    description = "IWD eduroam configurarion setup";
    script =
      let
        eduroamCert = builtins.fetchurl {
          url = "https://www.pki.dfn.de/fileadmin/PKI/zertifikate/T-TeleSec_GlobalRoot_Class_2.pem";
          sha256 = "b30989fd9e45c74bf417df74d1da639d1f04d4fd0900be813a2d6a031a56c845";
        };
        eduroamConfig = pkgs.writeText "eduroam.8021x" ''
            EAP-Method=PEAP
            EAP-Identity=eduroam@thm.de
            EAP-PEAP-Phase2-Method=MSCHAPV2
            EAP-PEAP-ServerDomainMask=*.thm.de
            EAP-PEAP-CACert=${eduroamCert}
            #ask on connection time or uncommend and enter user identity
            #EAP-PEAP-Phase2-Identity={{TH_IDENTITY}}
            ##ask on connection time or uncommend and enter password
            #EAP-PEAP-Phase2-Password={{TH_NETWORK_PW}}
            #
            #[Settings]
            #AutoConnect=true
          '';
      in
        '' cp ${eduroamConfig} "/var/lib/iwd/eduroam.8021x" '';
    wantedBy = [ "iwd.service" ];
    before = [ "iwd.service" ];
    #serviceConfig = {
    #  Type = "oneshot";
    #  RuntimeDirectoryPreserve = "yes";
    #};
  };
}
