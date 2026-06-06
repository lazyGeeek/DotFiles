return {
    "gelguy/wilder.nvim",
    config = function()
        local wilder = require("wilder")
        wilder.setup({ modes = { ":", "/", "?" } })

        wilder.set_option(
            "renderer",
            wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                min_width = "20%",
                max_height = "15%",
                reverse = 0,
                highlights = {
                    default = wilder.make_hl(
                        "WilderPopupMenu",
                        "Pmenu",
                        { { a = 1 }, { a = 1 }, { background = "#1E212B" } }
                    ),
                    accent = wilder.make_hl(
                        "WilderAccent",
                        "Pmenu",
                        { { a = 1 }, { a = 1 }, { foreground = "#58FFD6", background = "#1e1e2e" } }
                    ),
                },
                border = "single",
            }))
        )
    end
}
