return {
    "rebelot/kanagawa.nvim",
    config = function()
        require('kanagawa').setup({
            compile = false,             -- enable compiling the colorscheme
            undercurl = true,            -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true},
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = true,	     -- do not set background color
            dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
            terminalColors = true,       -- define vim.g.terminal_color_{0,17}
            colors = {                   -- add/modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors) -- add/modify highlights
                return {
                    LineNr       = { bg = "none" }, -- Sets line number background to transparent
                    CursorLineNr = { bg = "none" }, -- Sets current line number background to transparent

                    -- Remove backgrounds from other floating windows
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },

                    -- Fully transparent main window
                    -- Normal   = { bg = "none" },
                    -- NormalNC = { bg = "none" },

                    -- Transparent statuslines
                    StatusLine   = { bg = "none" },
                    -- StatusLineNC = { bg = "none" },
                    -- WinBar       = { bg = "none" },
                    -- WinBarNC     = { bg = "none" },
                    
                    -- Transparent sidebars/menus
                    -- VertSplit             = { bg = "none" },
                    -- TabLine               = { bg = "none" },
                    -- TabLineFill           = { bg = "none" },
                    -- TabLineSel            = { bg = "none" },
                    -- Folded                = { bg = "none" },
                    SignColumn            = { bg = "none" },
                    -- DiagnosticVirtualText = { bg = "none" },

                    -- Standard diagnostic virtual text and signs
                    -- DiagnosticVirtualTextError = { bg = "none" },
                    -- DiagnosticVirtualTextWarn  = { bg = "none" },
                    -- DiagnosticVirtualTextInfo  = { bg = "none" },
                    -- DiagnosticVirtualTextHint  = { bg = "none" },

                    -- Floating diagnostic windows (if using native LSP)
                    -- DiagnosticFloatingError = { bg = "none" },
                    -- DiagnosticFloatingWarn  = { bg = "none" },
                    -- DiagnosticFloatingInfo  = { bg = "none" },
                    -- DiagnosticFloatingHint  = { bg = "none" },
                }
            end,
            theme = "dragon",              -- Load "wave" theme
            background = {                 -- map the value of 'background' option to a theme
                dark = "dragon",           -- try "dragon" !
                light = "lotus"
            },
        });
        -- setup must be called before loading
        vim.cmd("colorscheme kanagawa");
    end,
    build = function()
        vim.cmd("KanagawaCompile");
    end,
}
