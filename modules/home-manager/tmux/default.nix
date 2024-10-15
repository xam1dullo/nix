{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    # Tmux versiyasi va boshqa parametrlar
    # config faylining to‘liq mazmunini yozishingiz mumkin
    config = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g mouse on

      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix
      set -g default-command /bin/zsh
      setw -g mode-keys vi
      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set -g visual-activity on
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      set -g @catppuccin_flavour 'mocha'
      set -g @tokyo-night-tmux_show_datetime 0
      set -g @tokyo-night-tmux_show_path 1
      set -g @tokyo-night-tmux_path_format relative
      set -g @tokyo-night-tmux_window_id_style dsquare
      set -g @tokyo-night-tmux_window_id_style dsquare
      set -g @tokyo-night-tmux_show_git 0

      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'christoomey/vim-tmux-navigator'
      #set -g @plugin 'dreamsofcode-io/catppuccin-tmux'
      set -g @plugin "janoamaral/tokyo-night-tmux"
      set -g @plugin 'tmux-plugins/tmux-yank'


      run "$HOME/.config/tmux/tpm/tpm" # always at end of file

      # set vi-mode
      set-window-option -g mode-keys vi
      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
    # config = ''
    #   set -g mouse on
    #   set -g history-limit 10000
    #   unbind C-b
    #   set-option -g prefix C-a
    #   bind-key C-a send-prefix
    #   bind h split-window -h
    #   bind v split-window -v
    #   unbind '"'
    #   unbind %
    #   bind-key Left select-pane -L
    #   bind-key Right select-pane -R
    #   bind-key Up select-pane -U
    #   bind-key Down select-pane -D
    #   bind-key r command-prompt "rename-session %%"
    #   set -g status on
    #   set -g status-interval 2
    #   set -g status-justify "centre"
    #   set -g status-left "#[fg=green]#H"
    #   set -g status-right "#[fg=yellow]#(cut -d' ' -f1 /proc/loadavg) #[fg=white]%Y-%m-%d %H:%M:%S"
    # '';
  };
}
