return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "dockerfile",
        "haskell",
        "javascript",
        "json",
        "lua",
        "markdown",
        "nix",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
      auto_install = false,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
