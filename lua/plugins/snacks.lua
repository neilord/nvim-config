local header = table.concat({
    "                                                                       ",
    "                                                                     ",
    "       ████ ██████           █████      ██                     ",
    "      ███████████             █████                             ",
    "      █████████ ███████████████████ ███   ███████████   ",
    "     █████████  ███    █████████████ █████ ██████████████   ",
    "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
    "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
    " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
}, "\n")

local dashboard_keys = {
    { icon = "  ", key = "n", desc = "New File", action = ":ene | startinsert" },
    { icon = "  ", key = "f", desc = "Find File", action = function() Snacks.picker.files() end },
    { icon = "󰊄  ", key = "t", desc = "Find Text", action = function() Snacks.picker.grep() end },
    { icon = "  ", key = "r", desc = "Recent Files", action = function() Snacks.picker.recent() end },
    { icon = "  ", key = "p", desc = "Plugins", action = ":Lazy" },
    {
        icon = "  ",
        key = "s",
        desc = "Settings",
        action = function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
    },
    { icon = "  ", key = "q", desc = "Quit", action = ":qa" },
}

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    -- every module is off unless listed here
    opts = {
        dashboard = {
            preset = { header = header, keys = dashboard_keys },
        },
        indent = {
            indent = {
                char = "▏",
                hl = {
                    "SnacksIndent1",
                    "SnacksIndent2",
                    "SnacksIndent3",
                    "SnacksIndent4",
                    "SnacksIndent5",
                    "SnacksIndent6",
                },
            },
            scope = { char = "▏" },
            animate = { enabled = false },
        },
        picker = {
            prompt = "   ",
            layout = { preset = "vertical", layout = { width = 0.6 } },
        },
        lazygit = {},
    },

    keys = {
        { "<leader>f", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>F", function() Snacks.picker.grep() end, desc = "Find Text" },
        { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>sh", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>sc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config" },
        { "<leader>g", function() Snacks.lazygit() end, desc = "LazyGit" },
    },
}
