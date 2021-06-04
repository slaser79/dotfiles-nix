{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-b";
    extraConfig = ''
      # enable mouse
      set -g mouse on

      # vim-like yank/paste
      bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
      bind-key -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
      # Update default binding of `Enter` to also use copy-pipe-copy
      unbind -T copy-mode-vi Enter
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"

      # hjkl pane traversal
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # KJ to swap panes up/down
      bind K swap-pane -U
      bind J swap-pane -D

      # status bar
      set -g status on
      set -g status-right ""
      set -g status-left ""

      set -g status-style bg=brightgreen,fg=white
      set -g pane-border-style bg=brightgreen,fg=brightgreen
      set -g pane-active-border-style bg=white,fg=white
    '';
  };
}
