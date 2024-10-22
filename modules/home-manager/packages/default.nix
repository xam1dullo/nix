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

    tmux
    curl
    rofi
    tldr
    yazi
    zathura
    direnv
    lsof
    yt-dlp
    xclip
    nest-cli
    wezterm

    # pgadmin4
    pgadmin4-desktopmode

    auto-cpufreq


    # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
    gst_all_1.gstreamer
    # Common plugins like "filesrc" to combine within e.g. gst-launch
    gst_all_1.gst-plugins-base
    # Specialized plugins separated by quality
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    # Plugins to reuse ffmpeg to play almost every video format
    gst_all_1.gst-libav
    # Support the Video Audio (Hardware) Acceleration API
    gst_all_1.gst-vaapi

  ]) ++ (with unstablePkgs; [
    # Add your unstable packages here
    # zed-editor
    vscode
    # discord
    postman
    nodejs_22
    pnpm
    # floorp
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    kitty
    # liberation_ttf
    fira-code
    fira-code-symbols
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ]);
}
