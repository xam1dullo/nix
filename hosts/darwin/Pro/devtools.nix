{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    jq
    ripgrep
    fd
    fzf
    direnv
    just
    bash-completion
    zsh-completions
    glab
  ];
}
