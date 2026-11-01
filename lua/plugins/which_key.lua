-- Popup of pending keymaps after a short pause; groups name the leader prefixes
return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
        preset = "helix",
        delay = 500,
        icons = { mappings = false },
        spec = {
            { "<leader>c", group = "Claude" },
            { "<leader>h", group = "Git Hunk" },
            { "<leader>r", group = "Refactor / Restart" },
            { "<leader>s", group = "Search" },
            { "<leader>t", group = "Toggle" },
            { "<leader>x", group = "Debug" },
        },
    },
}
