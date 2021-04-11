{ config, pkgs, ... }:

let
  trackedPlugins = pkgs.packages;
in
{
  home.packages = with pkgs; [
    fzy fd ripgrep
  ];

  programs.neovim = with pkgs; {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = builtins.readFile ./config/nvimrc;
    plugins = [
      pkgs.vimPlugins.vim-surround
      pkgs.vimPlugins.vim-fugitive
      {
        plugin = pkgs.vimPlugins.gruvbox;
        config = builtins.readFile ./config/gruvbox.vim;
      }
      trackedPlugins."gina.vim"
      trackedPlugins.emmet-vim
      trackedPlugins.vim-nix
      {
        plugin = trackedPlugins.vim-rescript;
        config = builtins.readFile ./config/vim-rescript.vim;
      }
      {
        plugin = trackedPlugins.vim-picker;
        config = builtins.readFile ./config/vim-picker.vim;
      }
      {
        plugin = trackedPlugins."vim-editorconfig";
        config = builtins.readFile ./config/editorconfig.vim;
      }
      {
        plugin = trackedPlugins.vim-baker;
        config = builtins.readFile ./config/baker.vim;
      }
      {
        plugin = pkgs.vimPlugins.vimwiki;
        config = builtins.readFile ./config/vimwiki.vim;
      }
      #pkgs.unstable.vimPlugins.telescope-nvim
      #pkgs.unstable.vimPlugins.telescope-fzy-native-nvim
      #{
      #  plugin = hardmode;
      #  #config = builtins.readFile ./config/hardmode.vim
      #}
      #trackedPlugins.Ada-Bundle
    ];
  };
}
