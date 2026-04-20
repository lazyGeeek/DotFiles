return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",       -- closest to VS default style
        "--offset-encoding=utf-16",    -- avoids warning with certain plugins
    },

    init_options = {
        usePlaceholders    = true,
        completeUnimported = true,
        clangdFileStatus   = true,
    }
}
