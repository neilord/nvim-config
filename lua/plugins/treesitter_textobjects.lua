local objects = {
    af = "@function.outer",
    ["if"] = "@function.inner",
    ac = "@class.outer",
    ic = "@class.inner",
}

return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",

    opts = { select = { lookahead = true } },

    config = function(_, opts)
        require("nvim-treesitter-textobjects").setup(opts)

        local select = require("nvim-treesitter-textobjects.select")
        for lhs, query in pairs(objects) do
            vim.keymap.set(
                { "x", "o" },
                lhs,
                function() select.select_textobject(query, "textobjects") end,
                { desc = query }
            )
        end
    end,
}
