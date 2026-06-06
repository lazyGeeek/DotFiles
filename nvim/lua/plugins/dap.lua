return { }
-- {
--   "mfussenegger/nvim-dap",

--   dependencies = {
--     "rcarriga/nvim-dap-ui",         -- VS Code-like debug UI panels
--     "nvim-neotest/nvim-nio",        -- required by dap-ui
--     "jay-babu/mason-nvim-dap.nvim", -- auto-install debug adapters
--   },

--   config = function()
--     local dap = require("dap")
--     local dapui = require("dapui")

--     -- Auto-install codelldb via mason
--     require("mason-nvim-dap").setup({
--       ensure_installed = { "codelldb" },
--       handlers = {},
--     })
--     dapui.setup()

--     -- Auto-open/close UI like VS Code
--     dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
--     dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
--     dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

--     -- Keymaps matching VS/VS Code defaults
--     vim.keymap.set("n", "<F5>",       dap.continue,          { desc = "Debug: Start/Continue" })
--     vim.keymap.set("n", "<F10>",      dap.step_over,         { desc = "Debug: Step Over" })
--     vim.keymap.set("n", "<F11>",      dap.step_into,         { desc = "Debug: Step Into" })
--     vim.keymap.set("n", "<S-F11>",    dap.step_out,          { desc = "Debug: Step Out" })
--     vim.keymap.set("n", "<F9>",       dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
--     vim.keymap.set("n", "<leader>dr", dap.repl.open,         { desc = "Debug: Open REPL" })
--   end,
-- },

