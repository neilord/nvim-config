-- the middle of the bar takes its colors from the theme in use, see config/theme.lua
local function dark() return { bg = require("config.theme").color("dark") } end
local function divider()
    local theme = require("config.theme")
    return { fg = theme.color("muted"), bg = theme.color("dark") }
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    opts = {
        options = {
            ignore_focus = { "neo-tree", "nvim-undotree", "diff", "lazy", "mason", "snacks_picker_input" },
            disabled_filetypes = { "snacks_dashboard" },
            always_divide_middle = false,
            refresh = { statusline = 100 },
            globalstatus = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
                { "diagnostics", symbols = { hint = "󰌵 ", info = "󰋼 ", warn = " ", error = "󰅙 " } },
            },
            lualine_c = {
                {
                    "filename",
                    color = dark,
                    separator = { right = "" },
                },
            },
            lualine_x = {
                {
                    "encoding",
                    color = dark,
                    separator = { left = "" },
                },
                {
                    function() return "" end,
                    color = divider,
                    padding = 0,
                },
                {
                    "fileformat",
                    color = dark,
                },
                {
                    function() return "" end,
                    color = divider,
                    padding = 0,
                },
                {
                    "filetype",
                    color = dark,
                },
            },
        },
    },
}
