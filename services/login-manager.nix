
{ pkgs, lib, ...}:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} --cmd sway";
        user = "sascha";
      };
      # This enables auto-login
      initial_session = {
        command = "sway";
        user = "sascha";
      };
    };
  };
}
