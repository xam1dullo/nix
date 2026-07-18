{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    focusEvents = true;
    historyLimit = 1000000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    # NOTE: HM emits each plugin's run-shell (and any per-plugin extraConfig
    # immediately before it) *before* the top-level extraConfig below. Options
    # a plugin reads at load time — the @*-bind keys that create bindings —
    # MUST therefore live in the plugin's own extraConfig, not the shared one,
    # or the plugin loads first and silently falls back to its default key.
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
      {
        # prefix+o : fzf session manager w/ zoxide + preview
        plugin = tmux-sessionx;
        extraConfig = ''
          set -g @sessionx-bind 'o'
          set -g @sessionx-zoxide-mode 'on'
          set -g @sessionx-auto-accept 'off'
          set -g @sessionx-filter-current 'false'
          set -g @sessionx-window-height '85%'
          set -g @sessionx-window-width '75%'
        '';
      }
      {
        # prefix+p : toggleable floating scratch terminal
        plugin = tmux-floax;
        extraConfig = ''
          set -g @floax-bind 'p'
          set -g @floax-width '80%'
          set -g @floax-height '80%'
          set -g @floax-border-color '#7daea3'
          set -g @floax-text-color '#d4be98'
          set -g @floax-change-path 'true'
        '';
      }
      {
        # prefix+Space : hint-copy paths/hashes/URLs (vimium-style)
        plugin = tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-key space
          set -g @thumbs-unique enabled
          set -g @thumbs-reverse enabled
        '';
      }
      {
        # prefix+u : open/copy URLs from the pane via fzf
        plugin = fzf-tmux-url;
        extraConfig = ''
          set -g @fzf-url-bind 'u'
          set -g @fzf-url-fzf-options '-p 60%,30% --prompt="url> " --border-label=" Open URL "'
          set -g @fzf-url-history-limit '2000'
        '';
      }
      # prefix+F : fzf UI over sessions/windows/panes/keybinds (default key)
      tmux-fzf
    ];
    prefix = "M-s";
    terminal = "tmux-256color";
    extraConfig = ''
      # Explicitly set prefix to Option+S (Meta-s)
      # Note: On macOS, ensure Ghostty has macos-option-as-alt = true (already configured)
      set -g prefix M-s
      unbind C-b
      set -g set-clipboard on

      # Pin the pane shell to a concrete store path. Without this tmux resolves
      # the login shell at server-start; during a broken activation window
      # /run/current-system/sw/bin/zsh can dangle and tmux falls back to
      # /bin/sh (login bash 3.2), losing PATH and zoxide. See system.nix note.
      set -g default-shell ${pkgs.zsh}/bin/zsh

      # Quality of life
      set -g renumber-windows on
      set -g detach-on-destroy off   # closing a session lands you in another, not out of tmux
      set -g set-titles on
      set -g set-titles-string "#S / #W"

      # Tool popups
      bind g display-popup -E -w 90% -h 90% lazygit
      bind d display-popup -E -w 90% -h 90% lazydocker
      bind f display-popup -E -w 90% -h 90% yazi

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

      # Status bar — Gruvbox Material, module/powerline style
      set -g status-position bottom
      set -g status-style "bg=#3c3836,fg=#d4be98"
      set -g status-left "#[fg=#282828,bg=#a9b665,bold] #S #[fg=#a9b665,bg=#3c3836]"
      set -g status-right "#[fg=#504945,bg=#3c3836]#[fg=#d4be98,bg=#504945]  #(whoami) #[fg=#d8a657,bg=#504945]#[fg=#282828,bg=#d8a657,bold]  %d/%m %H:%M "
      set -g status-right-length 60
      set -g status-left-length 30

      # Window status — number right, current highlighted, zoom flag indicator
      setw -g window-status-current-format "#[fg=#7daea3,bg=#3c3836]#[fg=#282828,bg=#7daea3,bold] #W#{?window_zoomed_flag,  ,} #[fg=#7daea3,bg=#504945]#[fg=#d4be98,bg=#504945] #I #[fg=#504945,bg=#3c3836]"
      setw -g window-status-format "#[fg=#504945,bg=#3c3836]#[fg=#d4be98,bg=#504945] #W #[fg=#a89984,bg=#504945] #I #[fg=#504945,bg=#3c3836]"
      setw -g window-status-separator " "
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
