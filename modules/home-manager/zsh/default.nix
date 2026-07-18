{
  lib,
  pkgs,
  ...
}@args:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
        };
      }
      {
        name = "zsh-fzf-history-search";
        file = "zsh-fzf-history-search.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "joshskidmore";
          repo = "zsh-fzf-history-search";
          rev = "master";
          sha256 = "sha256-6UWmfFQ9JVyg653bPQCB5M4jJAJO+V85rU7zP4cs1VI=";
        };
      }
    ];
    shellAliases = import ./aliases.nix args;

    initContent = lib.mkMerge [
      (lib.mkOrder 550 ''
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$HOME/.cache/zsh"
      '')
      (lib.mkAfter ''
        export BLAZINGLY_FAST="$HOME/blazingly-fast"
        export NIX_SHELL_WORKSPACE="$HOME/dev/nix-shell-workspace"

        # Keep Home Manager profile bins in PATH for long-lived shells.
        case ":$PATH:" in
          *":$HOME/.nix-profile/bin:"*) ;;
          *) export PATH="$HOME/.nix-profile/bin:$PATH" ;;
        esac
        case ":$PATH:" in
          *":/etc/profiles/per-user/$USER/bin:"*) ;;
          *) export PATH="/etc/profiles/per-user/$USER/bin:$PATH" ;;
        esac
        # Fallback for system packages (node, fnm, ...): PATH normally reaches
        # them via /run/current-system/sw/bin, but that symlink lives in
        # /var/run and can vanish after a reboot until activation re-runs.
        # The profile path below points at the same generation and survives.
        case ":$PATH:" in
          *":/nix/var/nix/profiles/system/sw/bin:"*) ;;
          *) export PATH="/nix/var/nix/profiles/system/sw/bin:$PATH" ;;
        esac

        # pnpm setup
        export PNPM_HOME="$HOME/.local/share/pnpm"
        case ":$PATH:" in
          *":$PNPM_HOME:"*) ;;
          *) export PATH="$PNPM_HOME:$PATH" ;;
        esac

        # fnm setup (eager) to keep node available in every shell session.
        if command -v fnm >/dev/null 2>&1; then
          eval "$(fnm env --use-on-cd --shell zsh)"
        fi

        # autojump
        if [ -f "${pkgs.autojump}/share/autojump/autojump.zsh" ]; then
          source "${pkgs.autojump}/share/autojump/autojump.zsh"
        fi

        if [ -f "$HOME/.zshrc_custom" ]; then
          source "$HOME/.zshrc_custom"
        fi

        # Source user-installed local env (created by some installers, e.g. uv)
        # If that env file isn't present, ensure ~/.local/bin is on PATH.
        if [ -f "$HOME/.local/bin/env" ]; then
          source "$HOME/.local/bin/env"
        else
          case ":$PATH:" in
            *":$HOME/.local/bin:"*) ;;
            *) export PATH="$HOME/.local/bin:$PATH" ;;
          esac
        fi

        # Suppress Node.js punycode deprecation warnings (DEP0040)
        export NODE_OPTIONS="--no-deprecation"          

        # Silence zoxide's doctor self-check. It misfires under Claude Code's
        # Bash tool, which replays a captured shell snapshot in a non-interactive
        # `zsh -c` where zoxide's "am I initialized last?" invariant can't hold,
        # printing the warning on every command. Our interactive init below is
        # already correct (last in the file), so the check has nothing to catch.
        export _ZO_DOCTOR=0

        # HM's built-in zsh integration is disabled (programs.zoxide.enableZshIntegration = false
        # in yazi.nix) because it inits too early and trips the _ZO_DOCTOR warning; init here instead,
        # at the true end of the shell initialization.
        if command -v zoxide >/dev/null 2>&1; then
          eval "$(zoxide init zsh --cmd cd)"
        fi

      '')
    ];

    profileExtra = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin ''
      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
      if [ -d /opt/local/bin ]; then
        export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
      fi
    '';
  };
}
