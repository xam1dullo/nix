{
  pkgs,
  ...
}:
  # NOTE: merged with recursiveUpdate (see vscode.nix) — return a plain attrset
  # via if/else, not lib.mkIf, or the merge corrupts the whole HM config.
  if pkgs.stdenv.hostPlatform.isDarwin
  then {
    programs.zed-editor = {
      enable = true;
      # App stays as a Homebrew cask (native .app + auto-update). package = null
      # means Nix manages only config + extensions, with no second copy in the store.
      package = null;

      # Merge into the on-disk settings.json rather than overwriting it, so live
      # prefs (SSH connections, agent servers, language models) are preserved.
      mutableUserSettings = true;

      extensions = [
        "catppuccin"
        "catppuccin-icons"
      ];

      userSettings = {
        icon_theme = "Catppuccin Mocha";
      };
    };
  }
  else { }
