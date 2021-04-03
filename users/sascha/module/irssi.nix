{ pkgs, ... }: let
  nickname = "GlancingMind";
  username = "GlancingMind";
  realname = "sascha";
in {
  #home.file.".irssi/default.theme".source = "${pkgs.sources.weed}";

  programs.irssi = {
    enable = false;
    networks = {
      freenode = {
        nick = nickname;
        autoCommands = [
          "/set nick ${nickname}"
          "/set user_name ${username}"
          "/set real_name ${realname}"
        ];

        server = {
          address = "chat.freenode.net";
          port = 6697;
          autoConnect = false;
        };
        channels = {
          home-manager.autoJoin = false;
        };
      };
    };
  };
}
