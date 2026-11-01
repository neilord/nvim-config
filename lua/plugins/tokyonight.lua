-- every custom color in the config lives here, so it survives :colorscheme reloads
local indent = { "#353E5B", "#384A5D", "#403A58", "#2C4755", "#3C4738", "#4D4339" }
local rainbow = { "#698cd6", "#68b3de", "#9a7ecc", "#25aac2", "#80a856", "#c49a5a" }

return {
    "folke/tokyonight.nvim",
    priority = 1000,

    opts = {
        style = "night",
        transparent = true,
        styles = {
            sidebars = "transparent",
            floats = "transparent",
        },

        on_colors = function(colors) colors.border_highlight = "#709ad2" end,
        on_highlights = function(hl, colors)
            hl.CursorLine = { bg = colors.none }
            hl.CursorLineNr = { fg = "#737aa2", bold = true }

            for i = 1, 6 do
                hl["SnacksIndent" .. i] = { fg = indent[i] }
                hl["RainbowDelimiter" .. i] = { fg = rainbow[i] }
            end
            hl.SnacksIndentScope = { fg = "#b0bcf2" }
            hl.SnacksDashboardHeader = { fg = "#709ad2" }
            hl.SnacksPickerInputBorder = { fg = "#9d7cd8" }
            hl.SnacksPickerInputTitle = { fg = "#9d7cd8" }
            hl.SnacksPickerPrompt = { fg = "#9d7cd8" }
        end,
    },

    config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd.colorscheme("tokyonight")
        vim.api.nvim_set_hl(0, "MatchParen", { link = "IlluminatedWordText" })
    end,
}
