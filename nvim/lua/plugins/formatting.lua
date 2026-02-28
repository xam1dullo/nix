return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        if vim.bo[bufnr].buftype ~= "" then
          return nil
        end
        return {
          timeout_ms = 800,
          lsp_fallback = true,
        }
      end,
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        nix = { "alejandra" },
        haskell = { "fourmolu", "ormolu" },
      },
      formatters = {
        prettier = {
          command = "prettier",
        },
        stylua = {
          command = "stylua",
        },
        alejandra = {
          command = "alejandra",
        },
        fourmolu = {
          command = "fourmolu",
        },
        ormolu = {
          command = "ormolu",
        },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.keymap.set("n", "<leader>cf", function()
        require("conform").format { async = true, lsp_fallback = true }
      end, { desc = "Format buffer" })
    end,
  },
}
