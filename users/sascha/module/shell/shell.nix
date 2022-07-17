{ pkgs, ... }:
{
  home.shellAliases = let
    fd = "${pkgs.fd}/bin/fd";
    fzy = "${pkgs.fzy}/bin/fzy";
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
