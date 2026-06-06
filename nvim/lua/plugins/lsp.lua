return {
    -- LSP Plugins
    "neovim/nvim-lspconfig",
    opts = {},
    dependencies = {
        -- Autocomplition
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",

        -- Breadcrumbs
        "SmiteshP/nvim-navic",
    },

    config = function()
        local navic = require("nvim-navic")

        navic.setup({
            lsp = { auto_attach = false }, -- we attach manually above
            highlight = true,
            separator = " > ",
        })

        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        -- Or on status line
        -- vim.o.statusline = "%{%v:lua.require'nvim-navic'.get_location()%}"

        local servers = {
            clangd = {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                    "--offset-encoding=utf-16",    -- avoids warning with certain plugins
                },

                init_options = {
                    usePlaceholders    = true,
                    completeUnimported = true,
                    clangdFileStatus   = true,
                },

                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                on_attach = function(client, bufnr)
                    
                    -- breadcrumbs
                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, bufnr)
                    end
                    
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end

                    -- Navigation
                    map("n", "gd",         vim.lsp.buf.definition,       "Go to Definition")
                    map("n", "gD",         vim.lsp.buf.declaration,      "Go to Declaration")
                    map("n", "gi",         vim.lsp.buf.implementation,   "Go to Implementation")
                    map("n", "gr",         vim.lsp.buf.references,       "References")
                    map("n", "gt",         vim.lsp.buf.type_definition,  "Go to Type Definition")
                    map("n", "K",          vim.lsp.buf.hover,            "Hover Docs")
                    map("n", "<C-k>",      vim.lsp.buf.signature_help,   "Signature Help")
                    map("n", "<C-r>n",     vim.lsp.buf.rename,           "Rename Symbol")
                    map("n", "<C-c>a",     vim.lsp.buf.code_action,      "Code Action")

                    -- Switch between header/source
                    map("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>", "Switch Header/Source")
                    
                    -- Diagnostics
                    -- map("n", "[d",   vim.diagnostic.goto_prev,  "Prev Diagnostic")
                    -- map("n", "]d",    vim.diagnostic.goto_next,  "Next Diagnostic")
                    -- map("n", "<C-d>", vim.diagnostic.open_float, "Diagnostic Float")

                    vim.keymap.set("i", "<S-Tab>", "<C-d>", { silent = true, desc = "Delete spaces" })

                    vim.keymap.set("n", "<leader>w", function()
                        vim.opt.list = not vim.opt.list:get()
                    end, { desc = "Toggle whitespace display" })
                end,
            },
        }

        local names = { }
        for name, _ in pairs(servers) do
            names[#names + 1] = name
        end

        for name, server in pairs(servers) do
            vim.lsp.config(name, server)
            vim.lsp.enable(name)
        end
    end
}
