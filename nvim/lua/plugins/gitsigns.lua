return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "-" },
            -- topdelete = { text = "‾" },
            -- changedelete = { text = "~" },
            -- untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        current_line_blame = false,
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, {
                    buffer = bufnr,
                    silent = true,
                    desc = desc,
                })
            end

            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, "Next Git change")

            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, "Previous Git change")

            map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Git hunk")
            map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Git hunk")
            map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Git hunk")
            map("n", "<leader>hb", gitsigns.blame_line, "Blame Git line")
            map("n", "<leader>hd", gitsigns.diffthis, "Diff Git file")
            map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo staged Git hunk")

            map("v", "<leader>hs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Stage selected Git hunk")

            map("v", "<leader>hr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, "Reset selected Git hunk")
        end,
    },
}
