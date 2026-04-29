return {
    -- LSP Plugins
    {
        -- Main LSP Configuration
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
                        "--fallback-style=llvm",       -- closest to VS default style
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

                        vim.keymap.set("i", "<S-Tab>", "<C-d>", { silent = true })

                        vim.keymap.set("n", "<leader>w", function()
                            vim.opt.list = not vim.opt.list:get()
                        end, { desc = "Toggle whitespace display" })

                        -- Toggle line comment with
                        vim.keymap.set("n", "<C-\\>", "gcc", { remap = true, desc = "Toggle line comment" })
                        vim.keymap.set("v", "<C-\\>", "gc", { remap = true, desc = "Toggle visual comment" })
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
    },

    -- Autocompletion (IntelliSense-like)
    {
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

                mapping = cmp.mapping.preset.insert({
                    ["<C-m>"] = cmp.mapping.complete(),       -- trigger manually, for some reason working on Ctrl+n
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]     = cmp.mapping(function(fallback) -- Tab to accept/navigate
                        if cmp.visible() then cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
                        else fallback() end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then luasnip.jump(-1)
                        else fallback() end
                    end, { "i", "s" }),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                }),

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
    },

    --Formatting (clang-format)
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                hpp = { "clang_format" },
                hxx = { "clang_format" },
                h   = { "clang_format" },
                cpp = { "clang_format" },
                cxx = { "clang_format" },
                cc  = { "clang_format" },
                c   = { "clang_format" }
            },
            format_on_save = {
                timeout_ms = 2000,
                lsp_fallback = true,
            },
        },

        config = function()
            vim.keymap.set({ "n", "v" }, "<C-c>f", function()
            require("conform").format({
                lsp_fallback = true,
                -- async = true,
                timeout_ms = 500,
            })
            end, { desc = "Format buffer" })
        end
    },

    -- Diagnostics panel
    {
        "folke/trouble.nvim",
        opts = { mode = "workspace_diagnostics" },
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "dx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "dX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "ds",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "dl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "dL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "dQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    -- Breadcrumbs in statusline
    {
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
    },

    -- Show whitespaces (using plugin)
    -- {
    --     "mcauley-penney/visual-whitespace.nvim",
    --     event = "ModeChanged *:[vV\\22]",
    --     opts = {
    --         enabled = true,
    --         highlight = { link = "Visual", default = true },
    --         match_types = {
    --             space = true,  -- ← shows only spaces
    --             tab   = true, -- hides tabs
    --             nbsp  = false, -- hides non‑breaking spaces
    --             lead  = true,
    --             trail = false,
    --         },
    --         list_chars = {
    --             space = "·",     -- visual glyph for spaces
    --             tab   = "↦",
    --             -- nbsp  = "␣",
    --             lead  = "·",
    --             -- trail = "›",
    --         },
    --         -- fileformat_chars = {
    --         --     unix = "↲",
    --         --     mac = "←",
    --         --     dos = "↙",
    --         -- },
    --         ignore = {
    --             filetypes = {},
    --             buftypes  = {},
    --         },
    --     },
    -- },

    -- Comments using plugin
    -- {
    --     "numToStr/Comment.nvim",
    --     opts = {},

    --     config = function()
    --         require("Comment").setup({
    --             mappings = {
    --                 basic = true,  -- Enables gcc/gc
    --                 extra = false, -- Disable gco/gcA if unwanted
    --             },
    --         })
    --         vim.keymap.set("n", "<C-/>", "gcc", { remap = true })  -- Ctrl+/ toggle
    --     end
    -- }
}
