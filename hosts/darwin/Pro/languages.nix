{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # JavaScript/TypeScript runtimes and package managers
    nodejs
    pnpm # → latest via the Darwin pnpm overlay (modules/nix/darwin.nix)
    nest-cli # NestJS CLI (`nest`)
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

    # AI Code Models
    claude-code
    railway

  ];
}
