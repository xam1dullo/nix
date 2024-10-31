{ pkgs, lib, ... }:
let
  determinateSystems = "curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix";
  isMacOS = pkgs.stdenv.hostPlatform.system == "aarch64-darwin" || pkgs.stdenv.hostPlatform.system == "x86_64-darwin";

  mac = lib.mkIf isMacOS {
    # Refresh
    clean = "nix store gc";
  };

  linux = lib.mkIf (!isMacOS) {
    # Refresh
    clean = "nix store gc && nix collect-garbage -d";
  };

  default = {
    # General aliases
    down = "cd ~/Downloads";
    ".." = "cd ..";
    "...." = "cd ../..";
    "celar" = "clear";
    ":q" = "exit";
    neofetchh = "fastfetch";
    ssh-hosts = "grep -P \"^Host ([^*]+)$\" $HOME/.ssh/config | sed 's/Host //'";
    ydl = "yt-dlp -o '%(title)s.%(ext)s' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'";
    adl = "yt-dlp -o '%(title)s.%(ext)s' -f 'bestaudio[ext=m4a]/best' --extract-audio";



    # Polite motherfucker!
    # Do you speak it?!
    please = "sudo";
    move = "mv";
    copy = "cp";
    remove = "rm";
    list = "ls";
    edit = "nvim";

    # Made with Rust
    top = "btop";
    cat = "bat";
    ls = "eza";
    sl = "eza";
    ps = "procs";
    grep = "rg";
    search = "rg";
    look = "fd";
    find = "fd";
    ping = "gping";
    time = "hyperfine";
    korgi = "cargo";

    # Refresh
    refresh = "source ~/.zshrc";

    # Development
    hack = "zellij";
    vim = "nvim";
    nvim = "nvim";
    zednix = "nohup zeditor --new --foreground . &";
    zn = "nohup zed --new --foreground . &";

    # Others (Developer)
    ports = "sudo lsof -PiTCP -sTCP:LISTEN";
    rit = "gitui";
    open = "xdg-open";
    dotenv = "eval export $(cat .env)";
    xclip = "xclip -selection c";
    speedtest = "curl -o /dev/null cachefly.cachefly.net/100mb.test";
    dockfm = "docker ps --all --format \"NAME:   {{.Names}}\nSTATUS: {{.Status}}\nPORTS:  {{.Ports}}\n\"";

    # Updating system
    update = "nix store gc && topgrade";
    homeupdate = "export NIXPKGS_ALLOW_INSECURE=1 && home-manager switch --flake .#khamidullo@nix --impure";
    nix-shell = "nix-shell --run zsh";
    nix-develop = "nix develop -c \"$SHELL\"";
    determinate = "${determinateSystems} | sh -s -- ";
    repair = "${determinateSystems} | sh -s -- repair";

    docker-ls-restart = "docker container ls -q | xargs docker container inspect --format '{{ .Name }}: {{.HostConfig.RestartPolicy.Name}}'";
    docker-stop-all = "docker ps -q | xargs docker stop";
    docker-compose-restart = "docker compose up --force-recreate --build -d";


  };

  cfg = lib.mkMerge [
    mac
    linux
    default
  ];
in
{
  config = {
    programs.zsh.shellAliases = cfg;
  };
}
