return {
    "folke/trouble.nvim",
    opts = {
        focus = true,
        -- mode = "workspace_diagnostics",
    },
    cmd = "Trouble",
    keys = {
        {
            "tx",
            "<cmd>Trouble diagnostics toggle<CR>",
            desc = "Open trouble workspace diagnostics",
        },
        {
            "tX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
            desc = "Open trouble document diagnostics",
        },
        {
            "ts",
            "<cmd>Trouble symbols toggle focus=false<CR>",
            desc = "Open trouble symbols",
        },
        {
            "tl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
            desc = "Open trouble LSP Definitions / references / ...",
        },
        {
            "tL",
            "<cmd>Trouble loclist toggle<CR>",
            desc = "Open trouble location list",
        },
        {
            "dQ",
            "<cmd>Trouble qflist toggle<CR>",
            desc = "Open trouble quickfix list",
        },
    },
}
