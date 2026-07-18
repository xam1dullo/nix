{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    jq
    ripgrep
    fd
    fzf
    direnv
    just
    ngrok
    bash-completion
    zsh-completions
    glab
  ];
}
