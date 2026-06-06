return {
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
}
