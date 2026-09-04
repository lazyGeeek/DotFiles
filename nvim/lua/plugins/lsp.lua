return {
    "neovim/nvim-lspconfig",
    opts = {},
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "SmiteshP/nvim-navic",
        "b0o/schemastore.nvim",
    },

    config = function()
        local navic = require("nvim-navic")

        navic.setup({
            lsp = { auto_attach = false },
            highlight = true,
            separator = " > ",
        })

        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

        vim.filetype.add({
            extension = {
                py = "python",
                mdx = "mdx",
            },
        })

        vim.filetype.add({
            extension = {
                py = "python",
            },
        })

        local servers = {
            "pyright",
            "clangd",
            "ts_ls",
            "eslint",
            "tailwindcss",
            "html",
            "cssls",
            "jsonls",
        }

        for _, name in ipairs(servers) do
            vim.lsp.config(name, require("lsp.servers." .. name))
            vim.lsp.enable(name)
        end
    end,
}

