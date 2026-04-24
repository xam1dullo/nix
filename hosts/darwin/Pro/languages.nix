{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # JavaScript/TypeScript runtimes and package managers
    nodejs
    pnpm
    bun
    deno
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
    qwen-code
    open-code-large
  ];
}
