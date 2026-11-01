-- Claude Code IDE integration: shares the current file and selection,
-- and opens Claude's proposed edits as native diffs to accept or reject.
-- Connect an external `claude` session with /ide, or open one inside Neovim with <leader>cc.
return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    event = "VeryLazy", -- the server must run before Claude can connect
    opts = {},
    keys = {
        { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
        { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
        { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Buffer to Claude" },
        { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send Selection to Claude" },
        { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude Diff" },
        { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject Claude Diff" },
    },
}
