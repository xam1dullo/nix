return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local lspconfig = require "lspconfig"
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "LSP definition")
        map("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
        map("n", "gr", vim.lsp.buf.references, "LSP references")
        map("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
        map("n", "K", vim.lsp.buf.hover, "LSP hover")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP code action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP rename")
        map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
      end

      vim.diagnostic.config {
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }

      local function setup(server, opts)
        local ok = pcall(function()
          lspconfig[server].setup(opts)
        end)
        return ok
      end

      local base = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      local servers = {
        lua_ls = {
          cmd = { "lua-language-server" },
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        eslint = {
          cmd = { "vscode-eslint-language-server", "--stdio" },
        },
        dockerls = {
          cmd = { "docker-langserver", "--stdio" },
        },
        jsonls = {
          cmd = { "vscode-json-language-server", "--stdio" },
        },
        yamlls = {
          cmd = { "yaml-language-server", "--stdio" },
        },
        bashls = {
          cmd = { "bash-language-server", "start" },
        },
        hls = {
          cmd = { "haskell-language-server-wrapper", "--lsp" },
        },
      }

      for server, opts in pairs(servers) do
        setup(server, vim.tbl_deep_extend("force", base, opts))
      end

      local ts_opts = vim.tbl_deep_extend("force", base, {
        cmd = { "typescript-language-server", "--stdio" },
      })
      if not setup("ts_ls", ts_opts) then
        setup("tsserver", ts_opts)
      end

      if not setup("nixd", vim.tbl_deep_extend("force", base, { cmd = { "nixd" } })) then
        setup("nil_ls", vim.tbl_deep_extend("force", base, { cmd = { "nil" } }))
      end

      if not setup("sqls", vim.tbl_deep_extend("force", base, { cmd = { "sqls" } })) then
        setup("sqlls", vim.tbl_deep_extend("force", base, { cmd = { "sql-language-server", "up", "--method", "stdio" } }))
      end
    end,
  },
}
