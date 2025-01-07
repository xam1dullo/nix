{pkgs, ...}: let
  # Import the unstable Nixpkgs package set
  unstablePkgs =
    import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
      sha256 = "0zymi654w7p2z0c2xpc5b404vsp66advpfn2bd2b6mjbdd8pkmwd"; # Replace with actual sha256
    })
    {
      inherit (pkgs) system;
      config = {
        allowUnfree = true;
      };
    };
in {
  # O'rnatiladigan paketlar

    environment.systemPackages = with pkgs; [
        openssl
    ];

 home.sessionVariables = {
    PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma}/bin/prisma-query-engine";
    PRISMA_MIGRATION_ENGINE_BINARY = "${pkgs.prisma}/bin/prisma-migration-engine";
    PRISMA_INTROSPECTION_ENGINE_BINARY = "${pkgs.prisma}/bin/prisma-introspection-engine";
    PRISMA_FMT_BINARY = "${pkgs.prisma}/bin/prisma-fmt";
  };

  home.packages =
    (with pkgs; [
      # Downloader
      aria
      # Developer Mode
      openssl
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
      # google-chrome

      vim
      git
      zsh
      tree
      obsidian
      fzf

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

      # Media
      moc
      yt-dlp
      feh
      imagemagick
      optipng
      peek

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
      kitty
      zulip
      lazydocker
      mongodb-compass
      docker
      docker-compose

      safeeyes # Eye-strain protection

      nodePackages.typescript
      nodePackages.live-server
      nodePackages.nodemon
      nodePackages.prettier
      nest-cli
      pavucontrol
      chromedriver

      simplescreenrecorder
      ngrok
      flyctl
      killall
      # Nix stuff
      cachix # adding/managing alternative binary caches hosted by Cachix
      comma # run software from without installing it
      niv # easy dependency management for nix projects
      nix-tree # visualize the dependency graph of a nix derivation
      alejandra # Nix code formatter
      nix-init # Command line tool to generate Nix packages from URLs
      nix-output-monitor # Use `nom <build|develop|shell>` to show aditional information while building

      screenkey
      shellcheck
      papirus-icon-theme
      nil
      nixd
      nixpkgs-fmt

      firefox
      # google-chrome

      gcc
      vim
      wget
      git
      zsh
      tree
      obsidian
      fzf
      # vscode

      vlc
      obs-studio

      termius
      htop
      virtualenv

      bluez
      bluez-tools

      telegram-desktop
      # bluez-utils

      # home manager
      home-manager
      zoxide
      starship
      gh
      # cc
      gcc
      zig
      bat
      unzip
      insomnia

      cmake
      gcc
      cmake-language-server
      gnumake
      checkmake
      gcc # c/c++ compiler, required by nvim-treesitter!
      llvmPackages.clang-unwrapped # c/c++ tools with clang-tools such as clangd
      lldb
      gnumake
      github-desktop
      # Papirus Icon Pack
      papirus-icon-theme

      # Various plugins for KDE
      kdePackages.kdeconnect-kde
      kdePackages.plasma-browser-integration

      # X server video bridge
      vulkan-tools
      wayland-utils
      xwaylandvideobridge
      kdePackages.kdeconnect-kde
      kdePackages.plasma-browser-integration
      vulkan-tools
      wayland-utils
      xwaylandvideobridge
      curl
      flameshot

      zulip-term
      keepassxc
      stacer
      baobab
      smartmontools
      flameshot
      libqalculate
      nfs-utils

      # Media
      moc
      yt-dlp
      feh
      imagemagick
      optipng
      peek

      # Video editing
      # davinci-resolve

      auto-cpufreq
      zulip
      # Browser for at least searching something
      librewolf
      # Papirus Icon Pack
      papirus-icon-theme
      pandoc
      texlive.combined.scheme-full
      certbot
    ])
    ++ (with unstablePkgs; [
      postman
      ghostty
      zoom-us
      thunderbird
      nodejs_22
      prisma
      zed-editor
      pnpm
      deno
      neovim
      alacritty
      wezterm
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
  #
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
# Agar har bir paketaning nima maqsadda foydalanilayotganligini tushuntirishni xohlasangiz, quyidagi ro'yxatga qarang:
# - `aria`: Biror faylni internetdan yuklab olish uchun foydalaniladi.
# - `gh`: GitHub CLI, GitHub bilan ishlashni osonlashtiradi.
# - `jq`: JSON ma'lumotlarini qayta ishlash va tahlil qilish uchun qulay vosita.
# - `wget`: Internetdan fayllarni yuklab olish uchun ishlatiladi.
# - `zola`: Blog va veb-saytlar yaratish uchun statik sayt generatori.
# - `gitui`: Git bilan ishlash uchun grafik interfeys.
# - `zellij`: Terminal multiplexer, bir nechta terminal sessiyasini boshqarish uchun ishlatiladi.
# - `netcat`: TCP/IP tarmoqlaridagi vosita, debugging va tarmoq ulanishlarini tahlil qilish uchun.
# - `direnv`: Muayyan katalogga kirganingizda avtomatik ravishda muhit o'zgaruvchilarini o'rnatish uchun.
# - `git-lfs`: Git uchun katta fayllarni boshqarish.
# - `gitoxide`: Git bilan ishlash uchun Rustda yozilgan vosita.
# - `fd`: Fayl tizimida qidirish uchun qulay vosita.
# - `bat`: Katta hajmdagi fayllarni ko'rish uchun qulay vosita.
# - `btop`: Tizim resurslarini tahlil qilish uchun vosita.
# - `eza`: Fayl tizimidagi kataloglarni ko'rish uchun qulay vosita.
# - `figlet`: Matnni ASCII san'ati sifatida ko'rsatish uchun.
# - `gping`: Ping buyruqning grafik versiyasi.
# - `hyperfine`: Buyruqlarni benchmarking qilish uchun vosita.
# - `lolcat`: Rangli matn chiqarish uchun.
# - `fastfetch`: Tizim ma'lumotlarini chiqarish uchun.
# - `onefetch`: Git repository haqida ma'lumotlarni chiqarish uchun.
# - `procs`: Tizim jarayonlarini ko'rish uchun qulay vosita.
# - `ripgrep`: Fayl tizimida qidirishni amalga oshiruvchi vosita.
# - `topgrade`: Barcha tizim dasturiy ta'minot yangilanishlarini tekshirish va yangilash uchun.
# - `libheif`: HEIF (High Efficiency Image Format) formatidagi rasmlarni ko'rish uchun.
# - `gnupg`: GPG (GNU Privacy Guard) yordamida shifrlash va tasdiqlash.
# - `tmux`: Terminal multiplexer, bir nechta terminal sessiyasini boshqarish uchun.
# - `curl`: URL orqali ma'lumot olish va yuborish uchun vosita.
# - `rofi`: Tizim menyusi va dasturlarni ishga tushiruvchi vosita.
# - `tldr`: Buyruqlarning qisqa va qulay tushuntirishlarini ko'rish uchun.
# - `yazi`: Terminalda kataloglarni ko'rish uchun vosita.
# - `zathura`: PDF hujjatlarini ko'rish uchun vosita.
# - `lsof`: Tizimdagi ochiq fayllarni ko'rish uchun vosita.
# - `yt-dlp`: YouTube va boshqa video saytlaridan videolarni yuklab olish uchun.
# - `xclip`: X11 clipboard bilan ishlash uchun vosita.
# - `nest-cli`: NestJS framework uchun CLI vositasi.
# - `pgadmin4-desktopmode`: PostgreSQL ma'lumotlar bazasini boshqarish vositasi.
# - `auto-cpufreq`: CPU chastotasini avtomatik boshqarish uchun vosita.
# - `gst_all_1.*`: GStreamer multimedia freymvorki bilan ishlash uchun vositalar.
# - `nil`: Bo'sh qiymat.
# - `nixd`: Nix-da dasturlarni boshqarish uchun vosita.
# - `nixpkgs-fmt`: Nix kodini formatlash vositasi.
# - `firefox`: Veb-brauzer.
# - `google-chrome`: Veb-brauzer.
# - `vim`: Matn muharriri.
# - `git`: Versiyalarni boshqarish tizimi.
# - `zsh`: Shell muhiti.
# - `tree`: Fayl tizimini daraxt ko'rinishida ko'rsatish.
# - `obsidian`: Bilim bazasi va yozuvlar uchun vosita.
# - `fzf`: Interaktiv qidirish vositasi.
# - `vlc`: Multimedia pleer.
# - `obs-studio`: Video yozish va jonli efirga uzatish vositasi.
# - `termius`: SSH mijoz.
# - `htop`: Tizim resurslarini ko'rish uchun vosita.
# - `virtualenv`: Python virtual muhitlarini boshqarish vositasi.
# - `bluez`: Bluetooth stack.
# - `bluez-tools`: Bluetooth vositalari.
# - `telegram-desktop`: Telegram mijoz dasturi.
# - `zoxide`: Kataloglarni tezda ochish uchun vosita.
# - `starship`: Shell prompt.
# - `clang`: C/C++ kompilatori.
# - `cl`: C/C++ kompilatori.
# - `zig`: Zig dasturlash tili.
# - `unzip`: ZIP arxivlarini ochish uchun vosita.
# - `vulkan-tools`: Vulkan API bilan ishlash uchun vositalar.
# - `wayland-utils`: Wayland tizimi uchun vositalar.
# - `xwaylandvideobridge`: X server video ko'prigi.
# - `ffmpeg-full`: FFmpeg to'liq versiyasi, media fayllarni qayta ishlash uchun.
# - `flameshot`: Ekran tasvirini olish vositasi.
# - `zulip-term`: Zulip mijoz dasturi.
# - `keepassxc`: Parol menejeri.
# - `stacer`: Tizim monitoring vositasi.
# - `baobab`: Diskni foydalanishni tahlil qilish vositasi.
# - `smartmontools`: SMART-disk monitoring vositasi.
# - `libqalculate`: Kalkulyator vositasi.
# - `nfs-utils`: NFS (Network File System) vositalari.
# - `moc`: Musiqa pleer.
# - `feh`: Rasmlarni ko'rish uchun vosita.
# - `imagemagick`: Rasmlarni qayta ishlash vositasi.
# - `optipng`: PNG rasmlarni optimallashtirish vositasi.
# - `peek`: Ekran tasvirini olish uchun vosita.
# - `safeeyes`: Ko'z sog'lig'ini himoya qilish uchun vosita.
# - `nodePackages.*`: Node.js paketlari.
# - `chromedriver`: Chrome uchun WebDriver.
# - `simplescreenrecorder`: Ekranni yozish uchun vosita.
# - `ngrok`: Mahalliy serverlarni internet orqali ochish uchun vosita.
# - `flyctl`: Fly.io uchun CLI vositasi.
# - `killall`: Processlarni o'ldirish uchun vosita.
# - `cachix`: Nix uchun kesh boshqarish vositasi.
# - `comma`: Dasturlarni o'rnatmasdan ishlatish vositasi.
# - `niv`: Nix loyihalari uchun bog'lanmalarni boshqarish vositasi.
# - `nix-tree`: Nix derivatsiyalarining bog'lanma grafikasini ko'rsatish vositasi.
# - `alejandra`: Nix kodini formatlash vositasi.
# - `nix-init`: Nix paketlarini URL-dan generatsiya qilish vositasi.
# - `nix-output-monitor`: Nix qurilish jarayonida qo'shimcha ma'lumotlarni ko'rsatish vositasi.
# - `screenkey`: Klaviatura tugmalarini ekranda ko'rsatish vositasi.
# - `shellcheck`: Shell skriptlarini tekshirish vositasi.
# - `papirus-icon-theme`: Papirus piktogramma to'plami.
# - `gcc`: C/C++ kompilatori.
# - `cmake`: Kross-platforma qurilish tizimi.
# - `cmake-language-server`: CMake uchun LSP (Language Server Protocol) serveri.
# - `gnumake`: GNU Make vositasi.
# - `checkmake`: Makefile-larni tekshirish vositasi.
# - `llvmPackages.clang-unwrapped`: Clang vositalari.
# - `lldb`: Debugger vositasi.
# - `github-desktop`: GitHub uchun grafik interfeys.
# - `kdePackages.*`: KDE tizimi uchun vositalar.
# - `librewolf`: Veb-brauzer.
# - `zen-browser.packages.*`: Zen Browser paketlari.
# - `postman`: API-larni test qilish vositasi.
# - `zoom-us`: Zoom video konferensiya dasturi.
# - `thunderbird`: Elektron pochta mijoz.
# - `nodejs_22`: Node.js 22 versiyasi.
# - `zed-editor`: Matn muharriri.
# - `pnpm`: Node.js paket boshqaruvchisi.
# - `deno`: Deno JavaScript/TypeScript runtime.
# - `neovim`: Matn muharriri.
# - `alacritty`: Terminal emulyatori.
# - `wezterm`: Terminal emulyatori.
# Har bir paket haqida batafsil tushuntirish berildi, agar yana savollaringiz bo'lsa, iltimos xabar bering.

