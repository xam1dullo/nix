{
  lib,
  pkgs,
  ...
}: let
  fontSize =
    if pkgs.stdenv.hostPlatform.isDarwin
    then "14"
    else "10";

  # Fresh server → trigger continuum restore via _boot, then land in "main".
  # Server already running → new window gets its own fresh session.
  tmuxInit = pkgs.writeShellScript "tmux-init" ''
    if ! ${lib.getExe pkgs.tmux} ls 2>/dev/null | grep -q .; then
      ${lib.getExe pkgs.tmux} new-session -d -s _boot
      ${lib.getExe pkgs.tmux} kill-session -t _boot 2>/dev/null || true
      exec ${lib.getExe pkgs.tmux} new-session -A -s main
    fi
    exec ${lib.getExe pkgs.tmux} new-session
  '';

  baseConfig = ''
    # command execs tmux, not a shell, so shell-integration (default: detect)
    # can't recognize it and never activates here (no OSC133/cwd tab titles
    # for this outer process) - accepted trade-off for tmux-on-launch.
    command = ${tmuxInit}
    font-family = JetBrainsMono Nerd Font
    font-size = ${fontSize}
    cursor-style = block
    cursor-style-blink = false
    window-padding-x = 2
    window-padding-y = 2

    # Clipboard: make nvim/tmux yanks reach the system clipboard (OSC52)
    # and copy on select. tmux runs `set-clipboard on`, this lets it through.
    copy-on-select = clipboard
    clipboard-read = allow
    clipboard-write = allow
    clipboard-trim-trailing-spaces = true
    # ponytail: keep paste protection on (trust boundary); bracketed paste
    # from nvim/tmux is unaffected. Drop to false only if it nags you.
    clipboard-paste-protection = true

    # Links: detect + Cmd+click to open (Cmd is the default modifier on macOS)
    link-url = true

    # Productivity
    mouse-hide-while-typing = true
    confirm-close-surface = false
    window-save-state = always
    resize-overlay = never

    # Gruvbox Material theme
    background = 282828
    foreground = d4be98
    selection-background = 45403d
    selection-foreground = d4be98
    palette = 0=#3c3836
    palette = 1=#ea6962
    palette = 2=#a9b665
    palette = 3=#d8a657
    palette = 4=#7daea3
    palette = 5=#d3869b
    palette = 6=#89b482
    palette = 7=#d4be98
    palette = 8=#3c3836
    palette = 9=#ea6962
    palette = 10=#a9b665
    palette = 11=#d8a657
    palette = 12=#7daea3
    palette = 13=#d3869b
    palette = 14=#89b482
    palette = 15=#d4be98
  '';

  darwinConfig = lib.optionalString pkgs.stdenv.hostPlatform.isDarwin ''
    macos-option-as-alt = true
    macos-titlebar-style = tabs
    font-thicken = true
    # Dropdown quick terminal: Cmd+` from anywhere, drops from the top
    keybind = global:cmd+grave_accent=toggle_quick_terminal
    quick-terminal-position = top
    quick-terminal-animation-duration = 0.1
  '';

  ghosttyConfig = baseConfig + darwinConfig;
in {
  # macOS: Ghostty reads from ~/Library/Application Support/com.mitchellh.ghostty/config
  # Linux: Ghostty reads from ~/.config/ghostty/config (XDG)
  home.file."Library/Application Support/com.mitchellh.ghostty/config" = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    text = ghosttyConfig;
  };
  xdg.configFile."ghostty/config" = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    text = ghosttyConfig;
  };
}
