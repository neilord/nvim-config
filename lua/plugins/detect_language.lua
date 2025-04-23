return {
    "spywhere/detect-language.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        languages = {
            "json",
            "sql",
            "typescript",
            "javascript",
            "python",
            "lua",
            "markdown",
        },
        max_lines = 0,
    },
enabled = false,

    -- events = { "InsertLeave", "TextChanged", "FileReadPost" },

    config = function(_, opts)
        require("detect-language").setup(opts)

        local events = { "InsertLeave", "TextChanged", "FileReadPost" }
        require("detect-language.utils.nvim").auto(events, function()
            if vim.fn.expand("%:e") == "" then
                vim.cmd("DetectLanguage")
                -- vim.cmd("silent! DetectLanguage")
                -- print "DONE"
            end
        end)
    end,

    keys = {
        { "<leader>ld", "<cmd>DetectLanguage<cr>", desc = "Detect Language" },
    },
}
