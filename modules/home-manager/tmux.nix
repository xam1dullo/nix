{pkgs, ...}: let
  sessionizer = pkgs.writeShellScript "tmux-sessionizer" ''
    selected=$(${pkgs.zoxide}/bin/zoxide query -i 2>/dev/null)
    [[ -z "$selected" ]] && exit 0
    # Strip $HOME prefix, replace slashes → unique path-based session name
    name=$(echo "$selected" | sed "s|^$HOME/||; s|/|_|g; s|[^a-zA-Z0-9_]|_|g")
    if ! tmux has-session -t "=$name" 2>/dev/null; then
      tmux new-session -ds "$name" -c "$selected"
    fi
    tmux switch-client -t "=$name"
  '';
in {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    focusEvents = true;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      continuum
    ];
    prefix = "M-s";
    terminal = "tmux-256color";
    extraConfig = ''
      # Explicitly set prefix to Option+S (Meta-s)
      # Note: On macOS, ensure Alacritty has option_as_alt = "Both" (already configured)
      set -g prefix M-s
      unbind C-b
      set -g set-clipboard on

      # Pin the pane shell to a concrete store path. Without this tmux resolves
      # the login shell at server-start; during a broken activation window
      # /run/current-system/sw/bin/zsh can dangle and tmux falls back to
      # /bin/sh (login bash 3.2), losing PATH and zoxide. See system.nix note.
      set -g default-shell ${pkgs.zsh}/bin/zsh

      # Auto-save & restore sessions (continuum + resurrect)
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'
      set -g @resurrect-capture-pane-contents 'on'

      # Quality of life
      set -g renumber-windows on
      set -g set-titles on
      set -g set-titles-string "#S / #W"

      # Tool popups
      bind g display-popup -E -w 90% -h 90% lazygit
      bind d display-popup -E -w 90% -h 90% lazydocker
      bind f display-popup -E -w 90% -h 90% yazi
      bind s display-popup -E -w 60% -h 50% "${sessionizer}"

      # Vim-like pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # New window/splits inherit current path
      bind c new-window -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"

      # Resize panes with vim keys
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Vim-like copy mode (mode-keys vi set via programs.tmux.keyMode above)
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

      # Better window navigation
      bind -r C-h select-window -t :-
      bind -r C-l select-window -t :+

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # Status bar — Gruvbox Material
      set -g status-position bottom
      set -g status-style "bg=#3c3836,fg=#d4be98"
      set -g status-left "#[fg=#282828,bg=#a9b665,bold] #S #[fg=#a9b665,bg=#3c3836]"
      set -g status-right "#[fg=#d8a657] %d/%m  %H:%M "
      set -g status-right-length 30
      set -g status-left-length 30

      # Window status
      setw -g window-status-current-style "fg=#d8a657,bold"
      setw -g window-status-current-format " #I:#W#F "
      setw -g window-status-format " #I:#W#F "
      setw -g window-status-activity-style "fg=#ea6962"

      # Pane border
      set -g pane-border-style "fg=#3c3836"
      set -g pane-active-border-style "fg=#7daea3"

      # Message style
      set -g message-style "fg=#282828,bg=#d8a657,bold"

      # Activity
      setw -g monitor-activity on
      set -g visual-activity on
    '';
  };
}
