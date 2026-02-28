_: {
  programs.lazydocker = {
    enable = true;
    settings = {
      commandTemplates = {
        dockerCompose = "docker compose";
      };
      gui = {
        theme = {
          activeBorderColor = ["green" "bold"];
          inactiveBorderColor = ["white"];
          selectedLineBgColor = ["default"];
          optionsTextColor = ["blue"];
        };
      };
    };
  };
}
