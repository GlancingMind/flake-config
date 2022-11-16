{ ... }:
{
  programs.bash = {
    historySize = 500;

    shellOptions = [
      "autocd" "cdable_vars" "cdspell"
      "checkhash"
      "checkwinsize"
      "cmdhist"
      "extglob" "globstar"
      "histappend" "histreedit" "histverify"
      "no_empty_cmd_completion"
    ];

    initExtra = ''
      # use ctrl-z to toggle in and out of bg
      stty susp undef
      bind '"\C-z":"fg\015"'
    '';
  };
}
