{ pkgs
, inputs
, ...
}:


# let
#   # Import the unstable Nixpkgs package set
#   unstablePkgs = import
#     (fetchTarball {
#       url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
#       # You can pin to a specific commit for reproducibility:
#       sha256 = "0bvz453039jpis0gj18h8i9qj8cyngn7l7lqgqk4d7nybszkygxk";
#       # url = "https://github.com/NixOS/nixpkgs/archive/<commit-hash>.tar.gz";
#     })
#     {
#       inherit (pkgs) system;
#       config = {
#         allowUnfree = true;
#       };
#     };
# in
let
  unstablePkgs = import inputs.nixpkgs-unstable {
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
    # cargo-update

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

    # Media encode & decode
    # ffmpeg
    libheif

    # GPG Signing
    gnupg

    tmux
    curl
    rofi
    tldr
    yazi
    zathura
    lsof
    yt-dlp
    xclip
    nest-cli
    wezterm

    # pgadmin4
    pgadmin4-desktopmode

    auto-cpufreq

    # GStreamer packages
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi

    nil
    nixd
    nixpkgs-fmt
    firefox
    google-chrome

    vim
    alacritty
    neovim
    git
    zsh
    tree
    obsidian
    fzf
    nodejs

    vlc
    obs-studio

    termius
    htop
    virtualenv

    bluez
    bluez-tools
    telegram-desktop

    # Home Manager
    zoxide
    starship
    gcc

    # clang
    cl
    zig
    unzip
    # insomnia

    # X server video bridge
    vulkan-tools
    wayland-utils
    xwaylandvideobridge

    ffmpeg-full
    flameshot

    zulip-term
    keepassxc
    stacer
    baobab
    smartmontools
    libqalculate
    nfs-utils

    # Archive tools
    unzip
    p7zip
    gnutar
    xz
    gzip
    bzip2
    rar
    pigz

    # Media
    moc
    yt-dlp
    feh
    imagemagick
    optipng
    peek


    zulip
    mongodb-compass
    docker-compose


      # Audio
    picard
    playerctl
    pulsemixer
    espeak


    
    

  ]) ++ (with unstablePkgs; [
    postman
    nodejs_22
    pnpm
    noto-fonts
    deno
    alejandra
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ]);
  # home.packages = (with pkgs;  [
  #   # Downloader
  #   aria

  #   # Developer Mode
  #   gh
  #   jq
  #   wget
  #   zola
  #   gitui
  #   zellij
  #   netcat
  #   direnv
  #   git-lfs
  #   gitoxide
  #   # cargo-update

  #   # Environment
  #   fd
  #   bat
  #   btop
  #   eza
  #   figlet
  #   gping
  #   hyperfine
  #   lolcat
  #   fastfetch
  #   onefetch
  #   procs
  #   ripgrep
  #   topgrade

  #   # For Prismlauncher
  #   # jdk17

  #   # Media encode & decode
  #   ffmpeg
  #   libheif

  #   # Anime
  #   # crunchy-cli

  #   # GPG Signing
  #   gnupg
  #   # sublime4

  #   # davinci-resolve-studio
  #   # pkgs.openssl # For Prisma

  #   tmux
  #   curl
  #   rofi
  #   tldr
  #   yazi
  #   zathura
  #   direnv
  #   lsof
  #   yt-dlp
  #   xclip
  #   nest-cli
  #   wezterm

  #   # pgadmin4
  #   pgadmin4-desktopmode

  #   auto-cpufreq


  #   # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
  #   gst_all_1.gstreamer
  #   # Common plugins like "filesrc" to combine within e.g. gst-launch
  #   gst_all_1.gst-plugins-base
  #   # Specialized plugins separated by quality
  #   gst_all_1.gst-plugins-good
  #   gst_all_1.gst-plugins-bad
  #   gst_all_1.gst-plugins-ugly
  #   # Plugins to reuse ffmpeg to play almost every video format
  #   gst_all_1.gst-libav
  #   # Support the Video Audio (Hardware) Acceleration API
  #   gst_all_1.gst-vaapi


  #   nil
  #   nixd
  #   nixpkgs-fmt

  #   firefox
  #   google-chrome

  #   vim
  #   alacritty
  #   # tmux
  #   neovim
  #   git
  #   zsh
  #   tree
  #   obsidian
  #   fzf
  #   nodejs
  #   # vscode

  #   vlc
  #   obs-studio

  #   termius
  #   htop
  #   virtualenv



  #   bluez
  #   bluez-tools

  #   telegram-desktop
  #   # bluez-utils

  #   # home manager
  #   home-manager
  #   zoxide
  #   starship
  #   gh
  #   # cc
  #   gcc
  #   clang
  #   cl
  #   zig
  #   bat
  #   unzip
  #   insomnia

  #   github-desktop
  #   # Various plugins for KDE
  #   kdePackages.kdeconnect-kde
  #   kdePackages.plasma-browser-integration

  #   # X server video bridge
  #   vulkan-tools
  #   wayland-utils
  #   xwaylandvideobridge

  #   vulkan-tools
  #   wayland-utils
  #   # wineWowPackages.waylandFull
  #   xwaylandvideobridge
  #   curl
  #   ffmpeg-full
  #   flameshot

  #   zulip-term
  #   keepassxc
  #   stacer
  #   baobab
  #   smartmontools
  #   flameshot
  #   libqalculate
  #   nfs-utils


  #   # Media
  #   moc
  #   yt-dlp
  #   feh
  #   imagemagick
  #   optipng
  #   peek

  #   auto-cpufreq
  #   zulip
  #   # mongodb
  #   mongodb-compass
  #   docker-compose
  # ]) ++ (with unstablePkgs; [
  #   # Add your unstable packages here
  #   # zed-editor
  #   # vscode
  #   # discord
  #   postman
  #   nodejs_22
  #   pnpm
  #   # floorp
  #   noto-fonts
  #   # noto-fonts-cjk
  #   # noto-fonts-emoji
  #   # kitty
  #   # liberation_ttf
  #   deno
  #   # fira-code
  #   # fira-code-symbols

  #   (nerdfonts.override {
  #     fonts = [ "JetBrainsMono" ];
  #   })
  # ]);

}
