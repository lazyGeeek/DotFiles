local shared = require("lsp.shared")

return {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_markers = { "package.json", ".git" },
    capabilities = shared.capabilities,
    on_attach = shared.on_attach,
}
