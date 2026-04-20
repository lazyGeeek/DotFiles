-- LSP Plugins
return {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",

    dependencies = {
        "mason-org/mason.nvim",
        
        -- Maps LSP server names between nvim-lspconfig and Mason package names.
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim'
    },
    
    
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        
        -- Autocomplition
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities() -- Used to enable autocomplition

        -- Enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local servers = {
            lua_ls = {},
            clangd = require("plugins.clangd"),
            rust_analyzer = {},
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
