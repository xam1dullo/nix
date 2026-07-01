{
  pkgs,
  mkShell,
  ...
}:
mkShell {
  nativeBuildInputs = with pkgs; [
    nixd
    deadnix
    statix
    alejandra
    git
    autojump
  ];
  shellHook = ''
    export EDITOR=nvim
  '';
}
