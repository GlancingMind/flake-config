{ pkgs, lib, services, ... }:
let
  username = "sascha";
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "video" "wheel" ];
    #home ="/home/sascha";
    shell = pkgs.zsh;
  };

  # required for zsh completion
  environment.pathsToLink = [ "/share/zsh" ];

  # required to start sway
  hardware.opengl.enable = true;

  home-manager = {
    # Doc: https://rycee.gitlab.io/home-manager/nixos-options.html
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${username}" = import ./home.nix;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "goland"
    "brgenml1lpr"
    "brgenml1cupswrapper"
  ];

  imports = [
    (services.virtualisation { inherit username; })
    (services.caches)
    (services.sound)
    (services.networking)
    (services.development)
    (services.localisation)
    (services.mounting { inherit username pkgs; })
    (services.printing)
    (services.streaming)
    (services.ssh)
  ];
}
