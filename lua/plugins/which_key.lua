-- Popup of what can follow a pending key, laid out in columns along the bottom.
-- Labels come from each mapping's desc; the spec below names the groups and relabels
-- Neovim's built-in maps, whose own descs are function names like vim.lsp.buf.hover().
return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
        preset = "modern",
        delay = 400,
        icons = { mappings = false, group = "" },
        sort = { "group", "alphanum" }, -- single keys A–Z, groups in the last column
        layout = { spacing = 4 },
        spec = {
            { "<leader>c", group = "Claude", mode = { "n", "x" } },
            { "<leader>h", group = "Git Hunk", mode = { "n", "x" } },
            { "<leader>l", group = "Code / LSP", mode = { "n", "x" } },
            { "<leader>r", group = "Replace", mode = { "n", "x" } },
            { "<leader>s", group = "Search", mode = { "n", "x" } },
            { "<leader>t", group = "Toggle" },
            { "<leader>x", group = "Debug", mode = { "n", "x" } },

            { "g", group = "Go to / Comment" },
            { "gr", group = "LSP" },
            { "z", group = "Fold / Scroll / Spell" },
            { "[", group = "Previous" },
            { "]", group = "Next" },
            { "<C-w>", group = "Window" },

            -- built-in LSP and comment maps
            { "K", desc = "Hover Docs" },
            { "grn", desc = "Rename Symbol" },
            { "gra", desc = "Code Action", mode = { "n", "x" } },
            { "grr", desc = "References" },
            { "gri", desc = "Implementations" },
            { "grt", desc = "Type Definition" },
            { "grx", desc = "Run Code Lens" },
            { "gO", desc = "Document Symbols" },
            { "gcc", desc = "Toggle Line Comment" },
            { "gc", desc = "Toggle Comment", mode = { "n", "x" } },
            { "[d", desc = "Previous Diagnostic" },
            { "]d", desc = "Next Diagnostic" },
            { "[D", desc = "First Diagnostic" },
            { "]D", desc = "Last Diagnostic" },
            { "<C-w>d", desc = "Diagnostic Float" },
        },
    },
}
