{ pkgs, services, ... }:
let
  username = "test";
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "video" ];
  };

  imports = [
    (services.virtualisation { inherit username; })
  ];
}
