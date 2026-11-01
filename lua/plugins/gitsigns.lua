return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",

    opts = {
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc }) end

            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, "Next Hunk")
            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, "Previous Hunk")

            -- stage_hunk toggles, so it also unstages
            map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Hunk")
            map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Hunk")
            map(
                "v",
                "<leader>hs",
                function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                "Stage Lines"
            )
            map(
                "v",
                "<leader>hr",
                function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                "Reset Lines"
            )
            map("n", "<leader>hS", gitsigns.stage_buffer, "Stage Buffer")
            map("n", "<leader>hR", gitsigns.reset_buffer, "Reset Buffer")
            map("n", "<leader>hp", gitsigns.preview_hunk_inline, "Preview Hunk")
            map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, "Blame Line")
            map("n", "<leader>hd", gitsigns.diffthis, "Diff File")
            map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Line Blame")

            map({ "o", "x" }, "ih", gitsigns.select_hunk, "Hunk")
        end,
    },
}
