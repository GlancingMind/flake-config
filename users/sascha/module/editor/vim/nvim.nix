{ config, pkgs, ... }:

let
  trackedPlugins = pkgs.packages;
in
{
  home.packages = with pkgs; [
    fzy fd ripgrep
    # Add support for --remote and --servername cli-flags
    neovim-remote
    nerdfonts
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = pkgs.neovim-unwrapped;
    extraConfig = builtins.readFile ./config/nvimrc;
    plugins = [
      {
        plugin = pkgs.vimPlugins.gruvbox;
        config = builtins.readFile ./config/gruvbox.vim;
      }
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
        config = builtins.readFile ./config/lspconfig.vim;
      }
      # NOTE have to use trackedPlugins, as these plugins seem not to load...
      trackedPlugins.hop-nvim
      trackedPlugins.nvim-lspkind
      trackedPlugins.nvim-cmp
      trackedPlugins.cmp-nvim-lsp
      trackedPlugins.cmp-buffer
      #pkgs.vimPlugins.lspkind-nvim
      #pkgs.unstablePkgs.vimPlugins.nvim-cmp
      #pkgs.unstablePkgs.vimPlugins.cmp-nvim-lsp
      #pkgs.unstablePkgs.vimPlugins.cmp-buffer
      {
        plugin = pkgs.vimPlugins.lspsaga-nvim;
        config = builtins.readFile ./config/lspsaga.vim;
      }
      pkgs.vimPlugins.vim-surround
      pkgs.vimPlugins.vim-fugitive
      pkgs.vimPlugins.vim-go
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
      #pkgs.unstablePkgs.vimPlugins.telescope-nvim
      #pkgs.unstablePkgs.vimPlugins.telescope-fzy-native-nvim
      #{
      #  plugin = hardmode;
      #  #config = builtins.readFile ./config/hardmode.vim
      #}
      #trackedPlugins.Ada-Bundle
    ];
  };
}
