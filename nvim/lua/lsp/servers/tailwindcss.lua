local shared = require("lsp.shared")

return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "mdx",
    },
    root_markers = {
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.mjs",
        "package.json",
        ".git",
    },
    capabilities = shared.capabilities,
    on_attach = shared.on_attach,
    settings = {
        tailwindCSS = {
            classFunctions = { "clsx", "cn", "cva" },
        },
    },
}
