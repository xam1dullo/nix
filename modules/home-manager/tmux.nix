_: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "M-s";
    terminal = "screen-256color";
    extraConfig = ''
      # Explicitly set prefix to Option+S (Meta-s)
      # Note: On macOS, ensure Alacritty has option_as_alt = "Both" (already configured)
      set -g prefix M-s
      unbind C-b
      
      # Vim-like pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Better splits
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"

      # Resize panes with vim keys
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Vim-like copy mode
      setw -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

      # Better window navigation
      bind -r C-h select-window -t :-
      bind -r C-l select-window -t :+

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # Status bar
      set -g status-position top
      set -g status-bg colour234
      set -g status-fg colour137
      set -g status-left ""
      set -g status-right "#[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S "
      set -g status-right-length 50
      set -g status-left-length 20

      # Window status
      setw -g window-status-current-format " #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F "
      setw -g window-status-format " #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F "

      # Pane border
      set -g pane-border-style fg=colour238
      set -g pane-active-border-style fg=colour51

      # Message style
      set -g message-style fg=colour232,bg=colour166,bold

      # Activity
      setw -g monitor-activity on
      set -g visual-activity on
    '';
  };
}
