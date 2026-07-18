{
  pkgs,
  ...
}:
let
  # pkgs.vscode-marketplace comes from the nix-vscode-extensions overlay (see
  # modules/nix/darwin.nix); using it here means unfree extensions honor this
  # config's allowUnfree, unlike referencing the flake input's prebuilt set.
  marketplace = pkgs.vscode-marketplace;
in
# NOTE: this repo merges home-manager modules with recursiveUpdate, not the
# module system, so `lib.mkIf` would be merged literally and corrupt the
# config. Return a plain attrset guarded by if/else, like neovim.nix.
if pkgs.stdenv.hostPlatform.isDarwin then
  {
    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode; # latest app; extensions come from the marketplace mirror below

      # Keep the extensions dir writable so ad-hoc UI installs still work; the
      # declared set below is always (re)installed on activation.
      mutableExtensionsDir = true;

      profiles.default = {
        # settings.json is deliberately NOT managed here. Setting userSettings
        # makes VS Code rewrite the whole file from Nix (no merge), which would
        # drop live/UI state and the machine-specific entries already on disk.
        # Extensions are the reproducible win; settings stay user-owned.
        extensions = with marketplace; [
          aaron-bond.better-comments
          anthropic.claude-code
          catppuccin.catppuccin-vsc
          christian-kohler.npm-intellisense
          christian-kohler.path-intellisense
          codezombiech.gitignore
          dbaeumer.vscode-eslint
          donjayamanne.githistory
          eamodio.gitlens
          github.github-vscode-theme
          github.vscode-github-actions
          github.vscode-pull-request-github
          jdinhlife.gruvbox
          mikestead.dotenv
          ms-azuretools.vscode-containers
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          ms-vscode.remote-explorer
          ms-vscode.remote-server
          ms-vscode.vscode-typescript-next
          mtxr.sqltools
          pkief.material-icon-theme
          planet57.vscode-beads
          redhat.vscode-yaml
          streetsidesoftware.code-spell-checker
          vitest.explorer
          vscodevim.vim
          wayou.vscode-todo-highlight
          yzhang.markdown-all-in-one
          esbenp.prettier-vscode
          bradlc.vscode-tailwindcss
          # Full parity with the machine's prior manual install set.
          alefragnani.project-manager
          cweijan.vscode-redis-client
          docker.docker
          formulahendry.code-runner
          mhutchie.git-graph
          openai.chatgpt
          redis.redis-for-vscode
          rvest.vs-code-prettier-eslint
          teabyii.ayu
          wakatime.vscode-wakatime
          wesbos.theme-cobalt2
        ];
      };
    };
  }
else
  { }
