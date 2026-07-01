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

        # Fallback init in case HM zoxide integration isn't loaded yet.
        if command -v zoxide >/dev/null 2>&1; then
          eval "$(zoxide init zsh --cmd cd)"
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

        # qwen-code 0.2.2 in nixpkgs has minified env-var names (process.env["n"]);
        # OPENAI_API_KEY/etc. are never read. Write creds to settings.json instead.
        # Run once after exporting DASHSCOPE_API_KEY (or OPENAI_API_KEY).
        qwen-setup() {
          local key="''${OPENAI_API_KEY:-$DASHSCOPE_API_KEY}"
          local base="''${OPENAI_BASE_URL:-https://dashscope-intl.aliyuncs.com/compatible-mode/v1}"
          local model="''${OPENAI_MODEL:-qwen3-coder-plus}"
          if [ -z "$key" ]; then
            echo "qwen-setup: set DASHSCOPE_API_KEY or OPENAI_API_KEY first" >&2
            return 1
          fi
          mkdir -p "$HOME/.qwen"
          rm -f "$HOME/.qwen/oauth_creds.json"
          umask 077
          cat > "$HOME/.qwen/settings.json" <<EOF
        {
          "security": { "auth": { "apiKey": "$key", "baseUrl": "$base" } },
          "model": { "name": "$model" }
        }
        EOF
          chmod 600 "$HOME/.qwen/settings.json"
          echo "qwen-setup: wrote ~/.qwen/settings.json (model=$model)"
        }

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
