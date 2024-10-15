{ inputs
, lib
, pkgs
, config
, packages
, self
, ...
}:


let
  # Import the unstable Nixpkgs package set
  unstablePkgs = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
      # You can pin to a specific commit for reproducibility:
      # url = "https://github.com/NixOS/nixpkgs/archive/<commit-hash>.tar.gz";
    })
    {
      inherit (pkgs) system;
      config = {
        allowUnfree = true;
      };
    };
in
{

  # O'rnatiladigan paketlar
  home.packages = (with pkgs;  [
    # Downloader
    aria

    # Developer Mode
    gh
    jq
    wget
    zola
    gitui
    zellij
    netcat
    direnv
    git-lfs
    gitoxide
    cargo-update

    # Environment
    fd
    bat
    btop
    eza
    figlet
    gping
    hyperfine
    lolcat
    fastfetch
    onefetch
    procs
    ripgrep
    topgrade

    # For Prismlauncher
    jdk17

    # Media encode & decode
    ffmpeg
    libheif

    # Anime
    crunchy-cli

    # GPG Signing
    gnupg
    sublime4

    # davinci-resolve-studio
    # pkgs.openssl # For Prisma

    curl
    rofi
    tldr
    yazi
    zathura
    direnv
    lsof
    yt-dlp
    xclip
    pgadmin4
    nest-cli
  ]) ++ (with unstablePkgs; [
    # Add your unstable packages here
    zed-editor
    vscode
    discord
    postman
    nodejs_22
    pnpm
    floorp
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ]);
}
