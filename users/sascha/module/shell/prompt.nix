{ pkgs, lib, ... }:
{
  starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      #character = {
      #  success_symbol = "→";
      #};
    };
  };
}
