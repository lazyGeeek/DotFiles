local shared = require("lsp.shared")

return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_markers = {
        "next.config.js",
        "next.config.mjs",
        "next.config.ts",
        "tsconfig.json",
        "jsconfig.json",
        "package.json",
        ".git",
    },
    capabilities = shared.capabilities,
    on_attach = shared.on_attach,
    settings = {
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayVariableTypeHints = true,
            },
        },
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayVariableTypeHints = true,
            },
        },
    },
}
