{ pkgs, ... }:
{
  programs.zsh = {
    defaultKeymap = "viins";
    # grml zsh overrides viins setting, need to apply it again after sourcing gmrl
    initExtraBeforeCompInit = ''
      source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
      bindkey -v
    '';
    dotDir = ".config/zsh";
    enableCompletion = true;
  };
}
