return {
    "HiPhish/rainbow-delimiters.nvim",
    init = function()
        -- colors are defined in config/theme.lua
        vim.g.rainbow_delimiters = {
            highlight = {
                "RainbowDelimiter1",
                "RainbowDelimiter2",
                "RainbowDelimiter3",
                "RainbowDelimiter4",
                "RainbowDelimiter5",
                "RainbowDelimiter6",
            },
        }
    end,
}
