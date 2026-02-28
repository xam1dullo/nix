{
  pkgs,
  lib,
  ...
}: let
  shared = {
    # made with rust from orzklv/nix
    # top = "btop";
    # htop = "btop";
    cat = "bat";
    ls = "eza";
    # sl = "eza";
    # ps = "procs";
    # grep = "rg";
    # search = "rg";
    # look = "fd";
    # find = "fd";
    # ping = "gping";
    # time = "hyperfine";

    down = "cd ~/Downloads";
    ".." = "cd ..";
    "...." = "cd ../..";
    "celar" = "clear";
    ":q" = "exit";

  # docker
    dps = "docker ps";
    dimages = "docker images";
    drm = "docker rm";
    drmi = "docker rmi";
    dstop = "docker stop";
    dstart = "docker start";
    dexec = "docker exec -it";
    dbash = "docker exec -it $1 /bin/bash";
    dash = "docker exec -it $1 /bin/sh";
    dlogs = "docker logs -f";
    dbuild = "docker build -t $1 .";
    dclean = "docker system prune -af --volumes";
    dkillall = "f() { docker kill $(docker ps -q); }; f";
  # docker compose 
    dc = "docker compose";
    dcup = "docker compose up -d";
    dcdown = "docker compose down";
    dclogs = "docker compose logs -f";
    dcbash = "docker compose exec $1 /bin/bash";
    dcsh = "docker compose exec $1 /bin/sh";

    # lazydocker
    lzd = "lazydocker";
    lg = "lazygit";
    
    # zednix = "nohup zed --new --foreground . &";
    # zn = "nohup zed --new --foreground . &";

    # configs
    nixconf = "nvim $BLAZINGLY_FAST -c \"cd $BLAZINGLY_FAST\"";

    # nix related
    nixupgrade = "f() { nix flake update --flake $BLAZINGLY_FAST $1 && nixrebuild }; f";
    nixpull = "f() { cd $BLAZINGLY_FAST && git pull && cd -}; f || cd -";
    nixpush = "f() { cd $BLAZINGLY_FAST && git add . && git commit -m \"automatically updated by nixpush\" && git push && cd - }; f || cd -";

    nix-shell-go = "nix-shell $NIX_SHELL_WORKSPACE/golang/latest/shell.nix";
  };
  linux = {
    nixrebuild = "f() { git -C $BLAZINGLY_FAST add . && sudo nixos-rebuild switch --flake $BLAZINGLY_FAST --impure $1 }; f";
    nixcleanup = "nix-env --delete-generations +2 && nix store gc && nix-channel --update && nix-env -u --always && nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration switch";
  };
  darwin = {
    nixrebuild = "f() { git -C $BLAZINGLY_FAST add . && sudo darwin-rebuild switch --flake $BLAZINGLY_FAST --impure $1 }; f";
  };
in
  lib.mkMerge [
    shared
    (lib.mkIf pkgs.stdenv.hostPlatform.isLinux linux)
    (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin darwin)
  ]
