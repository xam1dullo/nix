{ pkgs, ... }: {

  programs.git = {
    enable = true;
    lfs.enable = true;

    # User credentials
    userName = "Khamidullo Khudoyberdiev";
    userEmail = "khamidullo@gmail.com";

    extraConfig = {
      http.sslVerify = false;
    };

    # GPG Signing
    signing = {
      signByDefault = true;
      key = "00D27BC687070683FBB9137C3C35D3AF0DA1D6A8";
    };

    # Aliases
    aliases = {
      ch = "checkout";
      sw = "switch";
      swc = "switch -c";
      swa = "switch main";
    };

    # Git ignores
    ignores = [
      ".idea"
      "node_modules"
      "nohup.out"
    ];
  };

}
