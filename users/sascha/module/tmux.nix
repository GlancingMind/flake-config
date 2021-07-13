{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "ö";
    terminal = "tmux-256color";
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    escapeTime = 1;
    keyMode = "vi";
    extraConfig = ''
      # NOTE: use customize-mode to discover default tmux keybindings

      # Tell tmux, that the terminal emulator supports true color (24bit)
      set-option -ga terminal-overrides ",xterm-256color*:Tc"

      # bind ^ as another prefix key:
      unbind ^
      set -g prefix2 ^
      bind ^ send-prefix

      unbind space # Disable layout switching
      set -g mouse off # Disable mouse

      # Config copy-mode
      bind -T copy-mode-vi 'v' send -X begin-selection
      bind -T copy-mode-vi 'y' send -X copy-selection

      # Increase JumpToPane duration
      bind -N "Select current pane by given number" q display-panes -d 5000
      bind -N "Select current pane by given number" -TNormalMode q display-panes -d 5000

      bind h resize-pane -L \; switch-client -TNormalMode
      bind j resize-pane -D \; switch-client -TNormalMode
      bind k resize-pane -U \; switch-client -TNormalMode
      bind l resize-pane -R \; switch-client -TNormalMode
      bind -TNormalMode H resize-pane -L \; switch-client -TNormalMode
      bind -TNormalMode J resize-pane -D \; switch-client -TNormalMode
      bind -TNormalMode K resize-pane -U \; switch-client -TNormalMode
      bind -TNormalMode L resize-pane -R \; switch-client -TNormalMode

      unbind e
      bind -N "Open command prompt (e for execute)" e command-prompt
      bind -N "Open command prompt (e for execute)" -TNormalMode e command-prompt

      unbind d
      bind -N "Switch to DevideSpaceMode" -TNormalMode d switch-client -TDevideSpaceMode
      bind -N "Start devision mode" d switch-client -TDevideSpaceMode
      bind -N "Slice vertically" -TDevideSpaceMode v split-window -h \; switch-client -TNormalMode
      bind -N "Slice horicontally" -TDevideSpaceMode h split-window -v \; switch-client -TNormalMode
      bind -N "Slice vertically (full window)" -TDevideSpaceMode V split-window -fh \; switch-client -TNormalMode
      bind -N "Slice horicontally (full window)" -TDevideSpaceMode H split-window -fv \; switch-client -TNormalMode
    '';
    plugins = [];
  };
}
