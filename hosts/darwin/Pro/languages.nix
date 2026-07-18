{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # JavaScript/TypeScript runtimes and package managers
    nodejs
    pnpm
    unstable.bun
    unstable.deno
    unstable.go
    codex
    fnm
    autojump

    # Rust toolchain
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer

    # Haskell toolchain
    ghc
    cabal-install
    haskell-language-server
    stack

    # AI Code Models
    claude-code
    lmstudio
    railway

  ];
}
