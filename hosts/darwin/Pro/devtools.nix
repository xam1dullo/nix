{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    jq
    ripgrep
    fd
    fzf
    direnv
    bash-completion
    zsh-completions
  ];
}
