{ pkgs, lib, services, ... }:
let
  username = "sascha";
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "video" "wheel" ];
    #home ="/home/sascha";
    shell = pkgs.bashInteractive;
  };

  environment.pathsToLink = [
    "/share/zsh" # required for zsh completion
    "/share/bash-completion" # required for bash completion
  ];

  # required to start sway
  hardware.opengl.enable = true;

  home-manager = {
    # Doc: https://rycee.gitlab.io/home-manager/nixos-options.html
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${username}" = import ./home.nix;
  };

  nixpkgs.config.allowUnfreePredicate = let
    unfreePackageNames = import ./unfree-package-names.nix;
  in pkg: builtins.elem (lib.getName pkg) unfreePackageNames;

  imports = [
    (services.login-manager)
    (services.virtualisation { inherit username; })
    (services.bluetooth)
    (services.caches { inherit lib; trusted-user = username; })
    (services.sound)
    (services.networking)
    (services.development)
    (services.localisation)
    (services.mounting { inherit username pkgs; })
    (services.printing)
    (services.streaming)
    (services.ssh)
    (services.ausweisapp2)
  ];
}
