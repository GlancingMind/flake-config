{ pkgs, config, ... }:

{
  programs.borgmatic = {
    enable = true;

    backups = {
    #  laptop = {
    #    location = {
    #      sourceDirectories = [
    #        "/home/sascha/Desktop/"
    #      ];
    #      repositories = [
    #        "/media/2304-2F36/backup.borg"
    #      ];
    #      excludeHomeManagerSymlinks = true;
    #    };

    #    hooks.extraConfig = {
    #      before_backup = ''
    #          - findmnt /media/2304-2F36 > /dev/null || exit 75
    #      '';
    #    };
    #  };
    };
  };

  home.packages = with pkgs; [
    borgbackup
  ];

  xdg.configFile."borgmatic.d/laptop.yaml".text = ''
    location:
      source_directories:
        - /home/sascha/Desktop/

      repositories:
        - /media/2304-2F36/backup.borg

    retention:
      keep_daily: 7
      keep_weekly: 4
      keep_monthly: 9

    hooks:
      before_backup:
        - findmnt /media/2304-2F36 > /dev/null || exit 75
  '';
}
