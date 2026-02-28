return {
  {
    "mfussenegger/nvim-dap",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    keys = {
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Debug: Toggle breakpoint",
      },
      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Debug: Continue",
      },
      {
        "<leader>di",
        function() require("dap").step_into() end,
        desc = "Debug: Step into",
      },
      {
        "<leader>do",
        function() require("dap").step_over() end,
        desc = "Debug: Step over",
      },
      {
        "<leader>dO",
        function() require("dap").step_out() end,
        desc = "Debug: Step out",
      },
      {
        "<leader>dr",
        function() require("dap").repl.toggle() end,
        desc = "Debug: Toggle REPL",
      },
      {
        "<leader>dl",
        function() require("dap").run_last() end,
        desc = "Debug: Run last",
      },
      {
        "<leader>du",
        function() require("dapui").toggle() end,
        desc = "Debug: Toggle UI",
      },
    },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup {}

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "", numhl = "" })

      for _, adapter in ipairs { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" } do
        dap.adapters[adapter] = {
          type = "server",
          host = "127.0.0.1",
          port = "${port}",
          executable = {
            command = "js-debug",
            args = { "${port}" },
          },
        }
      end

      local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch current file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch npm run dev",
            runtimeExecutable = "pnpm",
            runtimeArgs = { "run", "dev" },
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            console = "integratedTerminal",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end

      require("dap.ext.vscode").load_launchjs(nil, {
        ["pwa-node"] = js_based_languages,
        ["node"] = js_based_languages,
      })
    end,
  },
}
