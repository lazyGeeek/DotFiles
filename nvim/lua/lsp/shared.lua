local M = {}

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

function M.on_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

    vim.keymap.set("i", "<S-Tab>", "<C-d>", {
        buffer = bufnr,
        silent = true,
        desc = "Delete spaces",
    })

    vim.keymap.set("n", "<leader>w", function()
        vim.opt.list = not vim.opt.list:get()
    end, {
        buffer = bufnr,
        desc = "Toggle whitespace display",
    })
end

return M
