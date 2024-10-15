{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    # Tmux versiyasi va boshqa parametrlar
    # config faylining to‘liq mazmunini yozishingiz mumkin
    config = ''
      set -g mouse on
      set -g history-limit 10000
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix
      bind h split-window -h
      bind v split-window -v
      unbind '"'
      unbind %
      bind-key Left select-pane -L
      bind-key Right select-pane -R
      bind-key Up select-pane -U
      bind-key Down select-pane -D
      bind-key r command-prompt "rename-session %%"
      set -g status on
      set -g status-interval 2
      set -g status-justify "centre"
      set -g status-left "#[fg=green]#H"
      set -g status-right "#[fg=yellow]#(cut -d' ' -f1 /proc/loadavg) #[fg=white]%Y-%m-%d %H:%M:%S"
    '';
  };
}
