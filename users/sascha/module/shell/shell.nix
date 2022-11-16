{ pkgs, lib, ... }:
{
  imports = [
    ./prompt.nix
    ./readline.nix
    ./bash.nix
    ./zsh.nix
  ];

  programs.starship.enable = true;

  programs.bash.enable = true;
  programs.starship.enableBashIntegration = true;

  programs.zsh.enable = true;
  programs.starship.enableZshIntegration = true;

  home.shellAliases = let
    fd = lib.getExe pkgs.fd;
    fzy = lib.getExe pkgs.fzy;
  in {

    jd = ''
      function jumpToDir() {
        cd $(${fd} --type directory | ${fzy} --lines=15 --query=$1)
      };
      jumpToDir
    '';
    open = ''
      function openIn() {
        "$1" $(${fd} --type file | ${fzy} --lines=15)
      };
      openIn
    '';
    sf = ''
      function selectFile() {
        ${fd} --type file | ${fzy} --lines=15 --query=$1
      };
      selectFile
    '';
  };
}
