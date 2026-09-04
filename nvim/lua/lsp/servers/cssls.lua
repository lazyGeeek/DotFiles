local shared = require("lsp.shared")

return {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
    capabilities = shared.capabilities,
    on_attach = shared.on_attach,
}
