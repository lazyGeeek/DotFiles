return {
    "stevearc/oil.nvim",
    opts = {},

    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },

    config = function()
        require("oil").setup({
            default_file_explorer = true, -- start up nvim with Oil isntead of netrw
            keymaps = {
                ["<C-h>"] = false, -- Prevent from horizontal split
                ["<C-c>"] = false, -- Prevent exit Oil by pressing Ctrl + c
                ["<A-h>"] = "actions.select_split", -- Open in horizontal split
                ["q"] = "actions.close", -- Close Oil
            },
            delete_to_trash = true, -- Put deleted files to trash
            view_options = {
                show_hidden = true, -- Show hidden files
            },
            skip_confirm_for_simple_edits = true,
        })

        vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Toggle float oil" })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            callback = function()
                vim.opt_local.cursorline = true
            end,
        })

    end

    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    -- lazy = false,
}
