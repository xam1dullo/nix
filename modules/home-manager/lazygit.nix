_: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showIcons = true;
        nerdFontsVersion = "3";
        showFileTree = true;
        showBottomLine = true;
        theme = {
          activeBorderColor = ["green" "bold"];
          inactiveBorderColor = ["white"];
          optionsTextColor = ["blue"];
          selectedLineBgColor = ["default"];
          unstagedChangesColor = ["red"];
        };
      };
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
      os = {
        editPreset = "nvim";
      };
    };
  };
}
