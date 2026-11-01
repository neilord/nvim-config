-- loaded by :colorscheme from config/theme.lua, which also holds the custom colors
return {
    "folke/tokyonight.nvim",
    lazy = true,

    opts = {
        transparent = true, -- the terminal's background shows through, and the theme script sets it
        styles = {
            sidebars = "transparent",
            floats = "transparent",
        },
        on_colors = function(colors) colors.border_highlight = "#709ad2" end,
    },
}
