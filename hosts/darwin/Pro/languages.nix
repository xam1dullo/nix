{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # JavaScript/TypeScript runtimes and package managers
    nodejs_20
    pnpm_10
    bun
    deno
    codex
    fnm
    zoxide
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
  ];
}
