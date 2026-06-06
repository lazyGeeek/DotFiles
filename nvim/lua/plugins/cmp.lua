return {
    "hrsh7th/nvim-cmp",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets", -- VS Code-style snippets
        "onsails/lspkind.nvim",         -- VS Code-style icons in completion
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args) luasnip.lsp_expand(args.body) end,
            },

            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000, keyword_length = 5 },
                { name = "luasnip",  priority = 750 },
                { name = "buffer",   priority = 500 },
                { name = "path",     priority = 250 },
            }),

            -- mapping = cmp.mapping.preset.insert({
            --     ["<C-m>"] = cmp.mapping.complete(),       -- trigger manually, for some reason working on Ctrl+n
            --     ["<CR>" ] = cmp.mapping.confirm({ select = true }),
            --     ["<Tab>"] = cmp.mapping(function(fallback) -- Tab to accept/navigate
            --         if cmp.visible() then cmp.select_next_item()
            --         elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            --         else fallback() end
            --     end, { "i", "s" }),
            --     ["<S-Tab>"]   = cmp.mapping(function(fallback)
            --         if cmp.visible() then cmp.select_prev_item()
            --         elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            --         else fallback() end
            --     end, { "i", "s" }),
            --     ["<C-e>"] = cmp.mapping.abort(),
            --     ["<C-d>"] = cmp.mapping.scroll_docs(4),
            --     ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            -- }),

            -- completion = {
            --     autocomplete = false,
            -- },

            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    menu = {
                        nvim_lsp = "[LSP]",
                        luasnip  = "[Snip]",
                        buffer   = "[Buf]",
                        path     = "[Path]",
                    },
                }),
            },
        })
    end
}

