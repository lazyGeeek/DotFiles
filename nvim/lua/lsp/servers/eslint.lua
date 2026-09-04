local shared = require("lsp.shared")

return {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
    },
    root_markers = {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.json",
        "package.json",
        ".git",
    },
    capabilities = shared.capabilities,
    on_attach = shared.on_attach,
    settings = {
        workingDirectory = { mode = "auto" },
    },
}
